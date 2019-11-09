{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">我的账户</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    {if $config['enable_kill']=="true"}
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">アカウント情報</div>
                                            <div class="account-flex">
                                                <span>注销账号</span>
                                                <a class="btn btn-flat" href="kill">
                                                    <span class="icon">not_interested</span>&nbsp;
                                                </a>
                                            </div>
                                        </div>
                                    {/if}
                                    <dl class="dl-horizontal">
                                        <dt>ユーザー名</dt>
                                        <dd>{$user->user_name}</dd>
                                        <dt>メールアドレス</dt>
                                        <dd>{$user->email}</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-doubleinner">
                                    <p class="card-heading">過去5分間のIP記録</p>
                                    <p>必ず自分またはShadowsocksの接続先のサーバーIPであることを確認してください。異常がある場合はできるだけ早くサーバー接続のパスワードを変更してください。</p>
                                </div>
                                <div class="card-table">
                                    <div class="table-responsive table-user">
                                        <table class="table table-fixed">
                                            <tr>

                                                <th>IP</th>
                                                <th>プロバイダー</th>
                                            </tr>
                                            {foreach $userip as $single=>$location}
                                                <tr>

                                                    <td>{$single}</td>
                                                    <td>{$location}</td>
                                                </tr>
                                            {/foreach}
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-doubleinner">
                                    <p class="card-heading">過去10件のログインしたIP記録</p>
                                    <p>必ず自分またはShadowsocksの接続先のサーバーIPであることを確認してください。異常がある場合はできるだけ早くアカウントのパスワードを変更してください。</p>
                                </div>
                                <div class="card-table">
                                    <div class="table-responsive table-user">
                                        <table class="table table-fixed">
                                            <tr>

                                                <th>IP</th>
                                                <th>プロバイダー</th>
                                            </tr>
                                            {foreach $userloginip as $single=>$location}
                                                <tr>

                                                    <td>{$single}</td>
                                                    <td>{$location}</td>
                                                </tr>
                                            {/foreach}
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</main>


{include file='user/footer.tpl'}
