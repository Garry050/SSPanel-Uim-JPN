{include file='user/header_info.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">サーバー情報</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="ui-card-wrap">
                <div class="row">
                    <div class="col-lg-12 col-sm-12">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner margin-bottom-no">
                                    <p class="card-heading">注意</p>
                                    <p>以下はSSHの接続設定です</p>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 col-sm-12">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner margin-bottom-no">
                                    <p class="card-heading">構成情報</p>
                                    <p>{$json_show}</p>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-lg-12 col-sm-12">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner margin-bottom-no">
                                    <p class="card-heading">構成方法</p>
                                    <p>続き</p>
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




