{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">サーバー中継設定</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-md-12">
            <section class="content-inner margin-top-no">

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <p>サーバー中継設定は通常日本国内から海外へ転送します。</p>
                            <p>ポート番号を自身のポート番号に設定します。</p>
                            <p>優先順位の値が高いほど、複数の適格なルールが共存する場合に使用されます。優先順位が同じ場合、最初に追加された設定が採用されます。</p>
                            <p>サーバーを中継させない設定にした場合、そのサーバーは通常のサーバーとして使用できるようになります。</p>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-main">
                        <div class="card-relayinner">
                            {if $is_relay_able}
                            <nav class="tab-nav">
                                <ul class="nav nav-justified">
                                    <li class="active">
                                        <a class="" data-toggle="tab" href="#rule_table">設定一覧</a>
                                    </li>
                                    <li>
                                        <a class="" data-toggle="tab" href="#link_table">経路一覧</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <div class="tab-content">
                            <div class="tab-pane fade active in" id="rule_table">
                                <div class="table-responsive table-user">
                                    {$rules->render()}
                                    <table class="table table-user">
                                        <tr>
                                            <!--	<th>ID</th>   -->
                                            <th>中継元</th>
                                            <th>中継先</th>
                                            <th>ポート番号</th>
                                            <th>優先順位</th>
                                            <th>操作</th>
                                        </tr>
                                        {foreach $rules as $rule}
                                            <tr>
                                                <!--<td>#{$rule->id}</td>-->
                                                {if $rule->source_node_id == 0}
                                                    <td>有効なサーバー</td>
                                                {else}
                                                    <td>{$rule->Source_Node()->name}</td>
                                                {/if}

                                                {if $rule->Dist_Node() == null}
                                                    <td>中継させない</td>
                                                {else}
                                                    <td>{$rule->Dist_Node()->name}</td>
                                                {/if}

                                                <td>{if $rule->port == 0}有効なポート{else}{$rule->port}{/if}</td>
                                                <td>{$rule->priority}</td>
                                                <td>
                                                    <a class="btn btn-brand"
                                                       {if $rule->user_id == 0}disabled{else}href="/user/relay/{$rule->id}/edit"{/if}>編集</a>
                                                    <a class="btn btn-brand-accent" id="delete" value="{$rule->id}"
                                                       {if $rule->user_id == 0}disabled{else}href="javascript:void(0);"
                                                       onClick="delete_modal_show('{$rule->id}')"{/if}>削除</a>
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                    {$rules->render()}
                                </div>
                            </div>
                            <div class="tab-pane fade" id="link_table">
                                <div class="table-responsive table-user">
                                    <table class="table">
                                        <tr>
                                            <th>ポート番号</th>
                                            <th>中継元サーバー</th>
                                            <th>終点サーバー</th>
                                            <th>中継先サーバー</th>
                                            <th>状態</th>
                                        </tr>

                                        {foreach $pathset as $path}
                                            <tr>
                                                <td>{$path->port}</td>
                                                <td>{$path->begin_node->name}</td>
                                                <td>{$path->end_node->name}</td>
                                                <td>{$path->path}</td>
                                                <td>{$path->status}</td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                </div>
                            </div>
                        </div>

                        {/if}

                    </div>
                </div>

                <div class="fbtn-container">
                    <div class="fbtn-inner"><a class="fbtn fbtn-lg fbtn-brand-accent" href="/user/relay/create">+</a>
                    </div>
                </div>

                <div aria-hidden="true" class="modal modal-va-middle fade" id="delete_modal" role="dialog"
                     tabindex="-1">
                    <div class="modal-dialog modal-xs">
                        <div class="modal-content">
                            <div class="modal-heading">
                                <a class="modal-close" data-dismiss="modal">×</a>
                                <h2 class="modal-title">本当に削除しますか？</h2>
                            </div>
                            <div class="modal-inner">
                                <p>確認</p>
                            </div>
                            <div class="modal-footer">
                                <p class="text-right">
                                    <button class="btn btn-flat btn-brand-accent waves-attach waves-effect"
                                            data-dismiss="modal" type="button">
                                        取消
                                    </button>
                                    <button class="btn btn-flat btn-brand-accent waves-attach" data-dismiss="modal"
                                            id="delete_input" type="button">
                                        确定
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
    function delete_modal_show(id) {
        deleteid = id;
        $("#delete_modal").modal();
    }


    $(document).ready(() => {

        {if !$is_relay_able}
        $("#result").modal();
        $$.getElementById('msg').innerHTML = `为了中转的稳定，您需要在<a href='/user/edit'>资料编辑</a>处设置协议为以下协议之一： <br>{foreach $relay_able_protocol_list as $single_text}{$single_text}<br>{/foreach}后方可设置中转规则！`
        {/if}

        function delete_id() {
            $.ajax({
                type: "DELETE",
                url: "/user/relay",
                dataType: "json",
                data: {
                    id: deleteid
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href=window.location.href", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } 发生错误了`;
                }
            });
        }

        $("#delete_input").click(() => {
            delete_id();
        });
    })

</script>
