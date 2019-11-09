{include file='user/main.tpl'}


<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">通信量の状況</h1>
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
                                    <p>一部のサーバーは通信量の確認ができません。</p>
                                    <p>ここでは過去72時間の状況が分単位で表示されます。</p>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="col-lg-12 col-sm-12">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner">
                                    <div id="log_chart" style="height: 300px; width: 100%;"></div>

                                    <script src="/assets/js/canvasjs.min.js"></script>

                                    <script type="text/javascript">
                                        window.onload = function () {
                                            var log_chart = new CanvasJS.Chart("log_chart",
                                                    {
                                                        zoomEnabled: true,
                                                        title: {
                                                            text: "過去72時間の通信量",
                                                            fontSize: 20

                                                        },
                                                        animationEnabled: true,
                                                        axisX: {
                                                            title: "時間",
                                                            labelFontSize: 14,
                                                            titleFontSize: 18
                                                        },
                                                        axisY: {
                                                            title: "KB",
                                                            lineThickness: 2,
                                                            labelFontSize: 14,
                                                            titleFontSize: 18
                                                        },

                                                        data: [
                                                            {
                                                                type: "scatter",
                                                                {literal}
                                                                toolTipContent: "<span style='\"'color: {color};'\"'><strong>記録した時刻: </strong></span>{x} <br/><span style='\"'color: {color};'\"'><strong>通信量: </strong></span>{y} KB <br/><span style='\"'color: {color};'\"'><strong>記録したサーバー: </strong></span>{jd}",
                                                                {/literal}

                                                                dataPoints: [


                                                                    {$i=0}
                                                                    {foreach $logs as $single_log}
                                                                    {if $i==0}
                                                                    {literal}
                                                                    {
                                                                        {/literal}
                                                                        x: new Date({$single_log->log_time*1000}),
                                                                        y:{$single_log->totalUsedRaw()},
                                                                        jd: "{$single_log->node()->name}"
                                                                        {literal}
                                                                    }
                                                                    {/literal}
                                                                    {$i=1}
                                                                    {else}
                                                                    {literal}
                                                                    , {
                                                                        {/literal}
                                                                        x: new Date({$single_log->log_time*1000}),
                                                                        y:{$single_log->totalUsedRaw()},
                                                                        jd: "{$single_log->node()->name}"
                                                                        {literal}
                                                                    }
                                                                    {/literal}
                                                                    {/if}
                                                                    {/foreach}

                                                                ]
                                                            }

                                                        ]
                                                    });

                                            log_chart.render();
                                        }
                                    </script>

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
