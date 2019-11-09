{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">問い合わせ</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-12">
            <section class="content-inner margin-top-no">

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <p>問題があったり質問したい場合は右下の+ボタンから送信してください</p>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-table">
                                <div class="table-responsive table-user">
                                    {$tickets->render()}
                                    <table class="table">
                                        <tr>

                                            <!--  <th>ID</th>   -->
                                            <th>日付</th>
                                            <th>タイトル</th>
                                            <th>状態</th>
                                            <th>操作</th>
                                        </tr>
                                        {foreach $tickets as $ticket}
                                            <tr>

                                                <!--   <td>#{$ticket->id}</td>  -->
                                                <td>{$ticket->datetime()}</td>
                                                <td>{$ticket->title}</td>
                                                {if $ticket->status==1}
                                                    <td>進行中</td>
                                                {else}
                                                    <td>終了済</td>
                                                {/if}
                                                <td>
                                                    <a class="btn btn-brand"
                                                       href="/user/ticket/{$ticket->id}/view">表示</a>
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                    {$tickets->render()}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="fbtn-container">
                    <div class="fbtn-inner">
                        <a class="fbtn fbtn-lg fbtn-brand-accent" href="/user/ticket/create">+</a>
                    </div>
                </div>
            </section>
        </div>
    </div>
</main>


{include file='user/footer.tpl'}
