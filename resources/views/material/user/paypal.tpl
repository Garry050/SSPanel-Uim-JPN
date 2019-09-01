<div class="row">
    <div class="col-lg-6 col-md-6">
        <p class="card-heading">チャージ金額</p>
        <div class="form-group form-group-label">
            <label class="floating-label" for="paypal-amount">金額</label>
            <input class="form-control" id="paypal-amount" type="number">
        </div>
    </div>
</div>

<div class="card-action">
    <div class="card-action-btn pull-left">
        <button class="btn btn-flat waves-attach" id="paypalSubmit" name="type">
            <img src="https://www.paypalobjects.com/webstatic/mktg/logo/AM_mc_vs_dc_ae.jpg" height="50px"/>
        </button>
    </div>
</div>
<script>
    $('#paypalSubmit').on('click', () => {
        const price = parseInt($$getValue('paypal-amount'), 10);
        //console.log("将要使用 " + type + " 充值" + price + "元");
        if (isNaN(price) || price <= 0) {
            $("#readytopay").modal('hide');
            $("#result").modal();
            $$.getElementById('msg').innerHTML = '金額が不正です'
            return;
        }        // alert('Stub');
        $.ajax('/user/payment/purchase', {
            data: {
                price: price
            },
            dataType: 'json',
            method: 'POST',
        }).done((data, textStatus, jqXHR) => {
            if (data.redirect_to) {
                location.assign(data.redirect_to)
            } else {
                $("#readytopay").modal('hide');
                $("#result").modal();
                $$.getElementById('msg').innerHTML = 'Invalid response';
            }
        }).fail((jqXHR, textStatus, errorThrown) => {
            $("#readytopay").modal('hide');
            $("#result").modal();
            $$.getElementById('msg').innerHTML = 'Error: ' + jqXHR.status;
        })
    })
</script>