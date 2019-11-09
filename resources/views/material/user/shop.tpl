{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">プラン一覧</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-12">
            <section class="content-inner margin-top-no">

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <p>プランは重複して購入できません。以前のプランをリセットされ新しく上書きされます</p>
                            <p><b>新しいプランを購入する場合は過去のプランの自動更新がオフにしてください。</b></p>
                            <p><i class="icon icon-lg">attach_money</i>残高：<font color="#399AF2" size="5">{$user->money}</font> 円</p>
                        </div>
                    </div>
                </div>

                <div class="ui-switch">
                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner ui-switch">
                                <div class="switch-btn" id="switch-cards">
                                    <a href="#" onclick="return false">
                                        <i class="mdui-icon material-icons">apps</i>
                                    </a>
                                </div>
                                <div class="switch-btn" id="switch-table">
                                    <a href="#" onclick="return false">
                                        <i class="mdui-icon material-icons">dehaze</i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="shop-flex">

                    {foreach $shops as $shop}
                        <div class="card">
                            <div class="card-main">
                                <div class="shop-name">{$shop->name}</div>
                                <div class="shop-price">{$shop->price}</div>
                                <div class="shop-tat">
                                    <span>{$shop->bandwidth()}</span> / <span>{$shop->class_expire()}</span>
                                </div>
                                <div class="shop-cube">
                                    <div>
                                        <div class="cube-detail">
                                            <span>Lv.</span>{$shop->user_class()}
                                        </div>
                                        <div class="cube-title">
                                            VIP
                                        </div>
                                    </div>
                                    <div>
                                        <div class="cube-detail">
                                            {if {$shop->connector()} == '0' }無制限{else}{$shop->connector()}
                                                <span></span>
                                            {/if}
                                        </div>
                                        <div class="cube-title">
                                            同時接続数
                                        </div>
                                    </div>
                                    <div>
                                        <div class="cube-detail">
                                            {if {$shop->speedlimit()} == '0' }無制限{else}{$shop->speedlimit()}
                                                <span> Mbps</span>
                                            {/if}
                                        </div>
                                        <div class="cube-title">
                                            速度制限
                                        </div>
                                    </div>

                                </div>
                                <div class="shop-content">
                                    <div class="shop-content-left">有効期限:</div>
                                    <div class="shop-content-right">{$shop->expire()}<span>日</span></div>
                                    <div class="shop-content-left">リセットサイクル:</div>
                                    <div class="shop-content-right">{if {$shop->reset()} == '0' }N / A{else}{$shop->reset_exp()}
                                            <span>日</span>
                                        {/if}</div>
                                    <div class="shop-content-left">通信量:</div>
                                    <div class="shop-content-right">{if {$shop->reset()} == '0' }N / A{else}{$shop->reset_value()}
                                            <span>GB</span>
                                            / {$shop->reset()}
                                            <span>日</span>
                                        {/if}</div>
                                </div>
                                <div class="shop-content-extra">
                                    {foreach $shop->content_extra() as $service}
                                        <div><span class="icon">{$service[0]}</span> {$service[1]}</div>
                                    {/foreach}
                                </div>
                                <a class="btn btn-brand-accent shop-btn" href="javascript:void(0);"
                                   onClick="buy('{$shop->id}',{$shop->auto_renew})">購入</a>
                            </div>
                        </div>
                    {/foreach}

                    <div class="flex-fix3"></div>
                    <div class="flex-fix4"></div>
                </div>

                <div class="shop-table">

                    {foreach $shops as $shop}
                        <div class="shop-gridarea">
                            <div class="card">
                                <div>
                                    <div class="shop-name"><span>{$shop->name}</span></div>
                                    <div class="card-tag tag-gold">VIP {$shop->user_class()}</div>
                                    <div class="card-tag tag-orange">{$shop->price} 円</div>
                                    <div class="card-tag tag-cyan">{$shop->bandwidth()} G</div>
                                    <div class="card-tag tag-blue">{$shop->class_expire()} 日</div>
                                </div>
                                <div>
                                    <i class="material-icons">expand_more</i>
                                </div>
                            </div>
                            <a class="btn btn-brand-accent shop-btn" href="javascript:void(0);"
                               onClick="buy('{$shop->id}',{$shop->auto_renew})">購入</a>

                            <div class="shop-drop dropdown-area">
                                <div class="card-tag tag-black">有効期限</div>
                                <div class="card-tag tag-blue">{$shop->expire()} 日</div>
                                {if {$shop->reset()} == '0' }
                                    <div class="card-tag tag-black">リセットサイクル</div>
                                    <div class="card-tag tag-blue">N/A</div>
                                {else}
                                    <div class="card-tag tag-black">リセットサイクル</div>
                                    <div class="card-tag tag-blue">{$shop->reset_exp()} 日</div>
                                    <div class="card-tag tag-black">リセット頻度</div>
                                    <div class="card-tag tag-blue">{$shop->reset_value()}GB/{$shop->reset()}日</div>
                                {/if}
                                {if {$shop->speedlimit()} == '0' }
                                    <div class="card-tag tag-black">速度制限</div>
                                    <div class="card-tag tag-blue">無制限</div>
                                {else}
                                    <div class="card-tag tag-black">速度制限</div>
                                    <div class="card-tag tag-blue">{$shop->speedlimit()} Mbps</div>
                                {/if}
                                {if {$shop->connector()} == '0' }
                                    <div class="card-tag tag-black">同時接続数</div>
                                    <div class="card-tag tag-blue">無制限</div>
                                {else}
                                    <div class="card-tag tag-black">同時接続数</div>
                                    <div class="card-tag tag-blue">{$shop->connector()}</div>
                                {/if}
                            </div>
                        </div>
                    {/foreach}

                </div>


                <div aria-hidden="true" class="modal modal-va-middle fade" id="coupon_modal" role="dialog"
                     tabindex="-1">
                    <div class="modal-dialog modal-xs">
                        <div class="modal-content">
                            <div class="modal-heading">
                                <a class="modal-close" data-dismiss="modal">×</a>
                                <h2 class="modal-title">割引コード</h2>
                            </div>
                            <div class="modal-inner">
                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="coupon">割引コードが有る場合は入力してください。ない場合はそのまま確定を推してください</label>
                                    <input class="form-control maxwidth-edit" id="coupon" type="text">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <p class="text-right">
                                    <button class="btn btn-flat btn-brand waves-attach" data-dismiss="modal"
                                            id="coupon_input" type="button">确定
                                    </button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>


                <div aria-hidden="true" class="modal modal-va-middle fade" id="order_modal" role="dialog" tabindex="-1">
                    <div class="modal-dialog modal-xs">
                        <div class="modal-content">
                            <div class="modal-heading">
                                <a class="modal-close" data-dismiss="modal">×</a>
                                <h2 class="modal-title">購入前の確認</h2>
                            </div>
                            <div class="modal-inner">
                                <p id="name">プラン名：</p>
                                <p id="credit">割引：</p>
                                <p id="total">価格：</p>

                                <div class="checkbox switch">
                                    <label for="disableothers">
                                        <input checked class="access-hide" id="disableothers" type="checkbox">
                                        <span class="switch-toggle"></span>以前のプランの自動更新を無効にする
                                    </label>
                                </div>
                                <br/>
                                <div class="checkbox switch" id="autor">
                                    <label for="autorenew">
                                        <input checked class="access-hide" id="autorenew" type="checkbox">
                                        <span class="switch-toggle"></span>自動更新を有効にする
                                    </label>
                                </div>

                            </div>

                            <div class="modal-footer">
                                <p class="text-right">
                                    <button class="btn btn-flat btn-brand waves-attach" data-dismiss="modal"
                                            id="order_input" type="button">确定
                                    </button>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                {include file='dialog.tpl'}

        </div>


    </div>
</main>


{include file='user/footer.tpl'}


<script>
    function buy(id, auto) {
        if (auto == 0) {
            document.getElementById('autor').style.display = "none";
        } else {
            document.getElementById('autor').style.display = "";
        }
        shop = id;
        $("#coupon_modal").modal();
    }

    ;(function () {

        //UI切换
        let elShopCard = $$.querySelector(".shop-flex");
        let elShopTable = $$.querySelector(".shop-table");

        let switchToCard = new UIswitch('switch-cards', elShopTable, elShopCard, 'flex', 'tempshop');
        switchToCard.listenSwitch();

        let switchToTable = new UIswitch('switch-table', elShopCard, elShopTable, 'flex', 'tempshop');
        switchToTable.listenSwitch();

        switchToCard.setDefault();
        switchToTable.setDefault();

        //手风琴
        let dropDownButton = document.querySelectorAll('.shop-table .card');
        let dropDownArea = document.querySelectorAll('.dropdown-area');
        let arrows = document.querySelectorAll('.shop-table .card i');

        for (let i = 0; i < dropDownButton.length; i++) {
            rotatrArrow(dropDownButton[i], arrows[i]);
            custDropdown(dropDownButton[i], dropDownArea[i]);
        }

    })();


    $("#coupon_input").click(function () {
        $.ajax({
            type: "POST",
            url: "coupon_check",
            dataType: "json",
            data: {
                coupon: $$getValue('coupon'),
                shop
            },
            success: (data) => {
                if (data.ret) {
                    $$.getElementById('name').innerHTML = `プラン名：${
                            data.name
                            }`;
                    $$.getElementById('credit').innerHTML = `割引：${
                            data.credit
                            }`;
                    $$.getElementById('total').innerHTML = `価格：${
                            data.total
                            }`;
                    $("#order_modal").modal();
                } else {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                }
            },
            error: (jqXHR) => {
                $("#result").modal();
                $$.getElementById('msg').innerHTML = `${
                        data.msg
                        } エラーが発生しました`;
            }
        })
    });

    $("#order_input").click(function () {

        if (document.getElementById('autorenew').checked) {
            var autorenew = 1;
        } else {
            var autorenew = 0;
        }

        if (document.getElementById('disableothers').checked) {
            var disableothers = 1;
        } else {
            var disableothers = 0;
        }

        $.ajax({
            type: "POST",
            url: "buy",
            dataType: "json",
            data: {
                coupon: $$getValue('coupon'),
                shop,
                autorenew,
                disableothers
            },
            success: (data) => {
                if (data.ret) {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                    window.setTimeout("location.href='/user/shop'", {$config['jump_delay']});
                } else {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                }
            },
            error: (jqXHR) => {
                $("#result").modal();
                $$.getElementById('msg').innerHTML = `${
                        data.msg
                        } エラーが発生しました`;
            }
        })
    });

</script>