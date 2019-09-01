<?php


namespace App\Services\Gateway;


use App\Models\Paylist;
use App\Services\Auth;
use App\Services\Config;
use App\Services\View;
use PayPal\Api\Amount;
use PayPal\Api\Payer;
use PayPal\Api\Payment;
use PayPal\Api\PaymentExecution;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Transaction;
use PayPal\Auth\OAuthTokenCredential;
use PayPal\Exception\PayPalConnectionException;
use PayPal\Rest\ApiContext;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Slim\Http\Body;
use Slim\Http\Request;
use Slim\Http\Response;

class PayPal extends AbstractPayment
{
    const ERR_PAYPAL_CONNECTION = 126;
    const ERR_UNKNOWN_ERROR = 127;
    /**
     * @var ApiContext
     */
    protected $api;

    public function __construct(string $clientId, string $clientSecret, string $mode = 'sandbox')
    {
        $this->api = new ApiContext(new OAuthTokenCredential($clientId, $clientSecret));
        $this->api->setConfig([
            'mode' => $mode,
        ]);
    }

    /**
     * @param $request ServerRequestInterface|Request
     * @param $response Response
     * @param $args array
     * @return ResponseInterface
     */
    public function purchase($request, $response, $args)
    {
        $price = $request->getParsedBodyParam('price', null);
        $price = filter_var($price, FILTER_SANITIZE_NUMBER_INT);
        if ($price <= 0) {
            return $response->withJson(['code' => -1, 'message' => 'invalid price'], 400);
        }

        $user = Auth::getUser();

        //todo
        $redirectUrls = new RedirectUrls();
        $redirectUrls->setReturnUrl(Config::get('baseUrl') . '/user/payment/return')
            ->setCancelUrl(Config::get('baseUrl') . '/user/code');

        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->tradeno = self::generateGuid();
        $pl->save();

        $payer = new Payer();
        $payer->setPaymentMethod('paypal');

        $amount = new Amount();
        $amount->setCurrency('JPY')->setTotal($price);

        $transaction = new Transaction();
        $transaction
            ->setAmount($amount)
            ->setDescription('Charge SSPanel ' . $pl->tradeno)
            ->setInvoiceNumber($pl->tradeno);

        $payment = new Payment();
        $payment
            ->setIntent('sale')
            ->setPayer($payer)
            ->setRedirectUrls($redirectUrls)
            ->setTransactions([$transaction]);

        try {
            $payment->create($this->api);
            $approvalUrl = $payment->getApprovalLink();

            return $response->withJson([
                'code' => 0,
                'redirect_to' => $approvalUrl,
            ]);
        } catch (PayPalConnectionException $ex) {
            return $response->withJson([
                'code' => self::ERR_PAYPAL_CONNECTION,
                'message' => "paypal connection error: [{$ex->getCode}] {$ex->getData()}"], 500);
        } catch (\Throwable $ex) {
            return $response->withJson([
                'code' => self::ERR_UNKNOWN_ERROR,
                'message' => "unknown error happen: {$ex->getMessage()}"], 500);
        }
    }

    /**
     * @param $request ServerRequestInterface
     * @param $response ResponseInterface
     * @param $args array
     */
    public function notify($request, $response, $args)
    {
        // TODO: Implement notify() method.
    }

    /**
     * @return string
     * @throws \SmartyException
     */
    public function getPurchaseHTML()
    {
        return View::getSmarty()->fetch('user/paypal.tpl');
    }

    /**
     * @param $request ServerRequestInterface
     * @param $response ResponseInterface
     * @param $args array
     * @return string
     */
    public function getReturnHTML($request, $response, $args)
    {
        $paymentId = $request->getQueryParams()['paymentId'] ?? null;
        $token = $request->getQueryParams()['token'] ?? null;
        $payerID = $request->getQueryParams()['PayerID'] ?? null;

        if (is_null($paymentId) || is_null($token) || is_null($paymentId)) {
            return $response->withStatus(400);
        }

//        try {

        $payment = Payment::get($paymentId, $this->api);

        $pid = $payment->getTransactions()[0]->getInvoiceNumber();
        $p = Paylist::where('tradeno', '=', $pid)->first();
        $money = $p->total;
//        } catch (\Throwable $ex) {
//        }

        if ($p->status == 1) {
            $success = 1;
        } else {
            try {
                $execution = new PaymentExecution();
                $execution->setPayerId($payerID);
                // Execute payment
                $result = $payment->execute($execution, $this->api);
                $this->postPayment($pid, 'PayPal');
                $success = 1;
            } catch (PayPalConnectionException $ex) {
                $success = 0;
            } /*catch (\Throwable $ex) {

            }*/
        }
        return View::getSmarty()->assign('money', $money)->assign('success', $success)->fetch('user/pay_success.tpl');


//            var_dump($result);
//        } catch (PayPalConnectionException $ex) {
//            echo $ex->getCode();
//            echo $ex->getData();
//            die($ex);
//        } catch (\Throwable $ex) {
//            die($ex);
//        }
    }

    /**
     * @param $request ServerRequestInterface
     * @param $response ResponseInterface
     * @param $args array
     */
    public function getStatus($request, $response, $args)
    {
        // TODO: Implement getStatus() method.
    }
}
