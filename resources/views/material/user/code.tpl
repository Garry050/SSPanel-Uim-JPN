{include file='user/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">チャージ</h1>


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
                                    <p class="card-heading">注意</p>
                                    <p>チャージが完了した場合は1分以内に自動的にページが更新されますが、更新されない場合は手動でページを更新してください。</p>
                                    <p><b>商品の自動更新が残高不足により更新できない場合、残高が自動更新の価格以上になった時点で自動的に差し引かれます。予めご了承ください。</b></p>
                                    {if $config["enable_admin_contact"] == 'true'}
                                        <p class="card-heading">チャージが完了したにもかかわらず残高が増えていない場合は管理人に連絡してください：</p>
                                        {if $config["admin_contact1"]!=null}
                                            <li>{$config["admin_contact1"]}</li>
                                        {/if}
                                        {if $config["admin_contact2"]!=null}
                                            <li>{$config["admin_contact2"]}</li>
                                        {/if}
                                        {if $config["admin_contact3"]!=null}
                                            <li>{$config["admin_contact3"]}</li>
                                        {/if}
                                    {/if}
                                    <br/>
                                    <p><i class="icon icon-lg">attach_money</i>残高：<font color="#399AF2" size="5">{$user->money}</font> 円</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                {if $pmw!=''}
                    <div class="col-lg-12 col-md-12">
                        <div class="card margin-bottom-no">
                            <div class="card-main">
                                <div class="card-inner">
                                    {$pmw}
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}

                {if $bitpay!=''}
                    <div class="col-lg-12 col-md-12">
                        <div class="card margin-bottom-no">
                            <div class="card-main">
                                <div class="card-inner">
                                    {$bitpay}
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}

                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    <div class="cardbtn-edit">
                                        <div class="card-heading">チャージ番号</div>
                                        <button class="btn btn-flat" id="code-update">
                                            <span class="icon">favorite_border</span>
                                        </button>
                                    </div>
                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="code">チャージ番号</label>
                                        <input class="form-control maxwidth-edit" id="code" type="text">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 col-md-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">

                                <div class="card-table">
                                    <div class="table-responsive table-user">
                                        {$codes->render()}
                                        <table class="table table-hover">
                                            <tr>
                                                <!--<th>ID</th> -->
                                                <th>支払い方法</th>
                                                <th>種類</th>
                                                <th>内容</th>
                                                <th>日時</th>

                                            </tr>
                                            {foreach $codes as $code}
                                                {if $code->type!=-2}
                                                    <tr>
                                                        <!--	<td>#{$code->id}</td>  -->
                                                        <td>{$code->code}</td>
                                                        {if $code->type==-1}
                                                            <td>残高のチャージ</td>
                                                        {/if}
                                                        {if $code->type==10001}
                                                            <td>通信量のチャージ</td>
                                                        {/if}
                                                        {if $code->type==10002}
                                                            <td>アカウントの更新</td>
                                                        {/if}
                                                        {if $code->type>=1&&$code->type<=10000}
                                                            <td>ランクの更新 - ランク{$code->type}</td>
                                                        {/if}
                                                        {if $code->type==-1}
                                                            <td>{$code->number} 円チャージ</td>
                                                        {/if}
                                                        {if $code->type==10001}
                                                            <td>{$code->number} GBチャージ</td>
                                                        {/if}
                                                        {if $code->type==10002}
                                                            <td>更新したアカウントの有効期限 {$code->number} 日</td>
                                                        {/if}
                                                        {if $code->type>=1&&$code->type<=10000}
                                                            <td>更新したランクの有効期限 {$code->number} 日</td>
                                                        {/if}
                                                        <td>{$code->usedatetime}</td>
                                                    </tr>
                                                {/if}
                                            {/foreach}
                                        </table>
                                        {$codes->render()}
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
                <div aria-hidden="true" class="modal modal-va-middle fade" id="readytopay" role="dialog" tabindex="-1">
                    <div class="modal-dialog modal-xs">
                        <div class="modal-content">
                            <div class="modal-heading">
                                <a class="modal-close" data-dismiss="modal">×</a>
                                <h2 class="modal-title">支払先へ接続中…</h2>
                            </div>
                            <div class="modal-inner">
                                <p id="title">もうしばらくお待ち下さい</p>
                            </div>
                        </div>
                    </div>
                </div>

                {include file='dialog.tpl'}
            </div>
        </section>
    </div>
</main>
<script>
    $(document).ready(function () {
        $("#code-update").click(function () {
            $.ajax({
                type: "POST",
                url: "code",
                dataType: "json",
                data: {
                    code: $$getValue('code')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
{literal}
                    $$.getElementById('msg').innerHTML = `エラー：${jqXHR.status}`;
{/literal}
                }
            })
        })
    })
</script>

{include file='user/footer.tpl'}
