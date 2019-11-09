{$load=$point_node->getNodeLoad()}

<div id="load{$id}_chart" style="height: 300px; width: 100%;"></div>
<div id="up{$id}_chart" style="height: 300px; width: 100%;"></div>
<div id="alive{$id}_chart" style="height: 300px; width: 100%;"></div>
<div id="speedtest{$id}_chart" style="height: 300px; width: 100%;"></div>
<div id="speedtest{$id}_ping_chart" style="height: 300px; width: 100%;"></div>

<script type="text/javascript">
    $().ready(function () {
        chart{$id} = new CanvasJS.Chart("load{$id}_chart",
                {
                    title: {
                        text: "サーバーの負荷状況 {$prefix}"
                    },
                    data: [
                        {
                            type: "line",
                            dataPoints: [
                                {$i=0}
                                {foreach $load as $single_load}
                                {if $i==0}
                                {literal}
                                {
                                    {/literal}
                                    x: new Date({$single_load->log_time*1000}), y:{$single_load->getNodeLoad()}
                                    {literal}
                                }
                                {/literal}
                                {$i=1}
                                {else}
                                {literal}
                                , {
                                    {/literal}
                                    x: new Date({$single_load->log_time*1000}), y:{$single_load->getNodeLoad()}
                                    {literal}
                                }
                                {/literal}
                                {/if}
                                {/foreach}

                            ]
                        }
                    ]
                });


        up_chart{$id} = new CanvasJS.Chart("up{$id}_chart",
                {
                    title: {
                        text: "最新のサーバーのオンライン状況 {$prefix} - オンライン時間 {$point_node->getNodeUptime()}"
                    },
                    data: [
                        {
                            //startAngle: 45,
                            indexLabelFontSize: 20,
                            indexLabelFontFamily: "Garamond",
                            indexLabelFontColor: "darkgrey",
                            indexLabelLineColor: "darkgrey",
                            yValueFormatString: "##0.00\"%\"",
                            indexLabelPlacement: "outside",
                            type: "doughnut",
                            showInLegend: true,
                            dataPoints: [
                                {
                                    y: {$point_node->getNodeUpRate()*100},
                                    label: "稼働率",
                                    legendText: "稼働率 {number_format($point_node->getNodeUpRate()*100,2)}%",
                                    indexLabel: "稼働率 {number_format($point_node->getNodeUpRate()*100,2)}%"
                                },
                                {
                                    y: {(1-$point_node->getNodeUpRate())*100},
                                    label: "停止率",
                                    legendText: "停止率 {number_format((1-$point_node->getNodeUpRate())*100,2)}%",
                                    indexLabel: "停止率 {number_format((1-$point_node->getNodeUpRate())*100,2)}%"
                                }
                            ]
                        }
                    ]
                });

        {$load=$point_node->getNodeAlive()}
        alive_chart{$id} = new CanvasJS.Chart("alive{$id}_chart",
                {
                    title: {
                        text: "過去1日に使用したユーザー数 {$prefix}"
                    },
                    data: [
                        {
                            type: "line",
                            yValueFormatString: "##0\"人\"",
                            dataPoints: [
                                {$i=0}
                                {foreach $load as $single_load}
                                {if $i==0}
                                {literal}
                                {
                                    {/literal}
                                    x: new Date({$single_load->log_time*1000}),
                                    y:{$single_load->online_user},
                                    label: "オンライン人数"
                                    {literal}
                                }
                                {/literal}
                                {$i=1}
                                {else}
                                {literal}
                                , {
                                    {/literal}
                                    x: new Date({$single_load->log_time*1000}),
                                    y:{$single_load->online_user},
                                    label: "オンライン人数"
                                    {literal}
                                }
                                {/literal}
                                {/if}
                                {/foreach}

                            ]
                        }
                    ]
                });



        {$speedtests=$point_node->getSpeedtestResult()}
        speedtest_chart{$id} = new CanvasJS.Chart("speedtest{$id}_chart",
                {
                    title: {
                        text: "最新のサーバー遅延測定グラフ {$prefix}"
                    },
                    axisY: {
                        suffix: " ms"
                    },
                    data: [
                        {
                            type: "line",
                            showInLegend: true,
                            legendText: "中国電信の遅延",
                            yValueFormatString: "##0\"ms\"",
                            dataPoints: [
                                {$i=0}
                                {foreach $speedtests as $single_speedtest}
                                {if $i==0}
                                {literal}
                                {
                                    {/literal}
                                    x: new Date({$single_speedtest->datetime*1000}),
                                    y:{$single_speedtest->getTelecomPing()},
                                    label: "中国電信の遅延"
                                    {literal}
                                }
                                {/literal}
                                {$i=1}
                                {else}
                                {literal}
                                , {
                                    {/literal}
                                    x: new Date({$single_speedtest->datetime*1000}),
                                    y:{$single_speedtest->getTelecomPing()},
                                    label: "中国電信の遅延"
                                    {literal}
                                }
                                {/literal}
                                {/if}
                                {/foreach}

                            ]
                        },
                        {
                            type: "line",
                            showInLegend: true,
                            legendText: "中国聯通の遅延",
                            yValueFormatString: "##0\"ms\"",
                            dataPoints: [
                                {$i=0}
                                {foreach $speedtests as $single_speedtest}
                                {if $i==0}
                                {literal}
                                {
                                    {/literal}
                                    x: new Date({$single_speedtest->datetime*1000}),
                                    y:{$single_speedtest->getUnicomPing()},
                                    label: "中国聯通の遅延"
                                    {literal}
                                }
                                {/literal}
                                {$i=1}
                                {else}
                                {literal}
                                , {
                                    {/literal}
                                    x: new Date({$single_speedtest->datetime*1000}),
                                    y:{$single_speedtest->getUnicomPing()},
                                    label: "中国聯通の遅延"
                                    {literal}
                                }
                                {/literal}
                                {/if}
                                {/foreach}

                            ]
                        },
                        {
                            type: "line",
                            showInLegend: true,
                            legendText: "中国移動の遅延",
                            yValueFormatString: "##0\"ms\"",
                            dataPoints: [
                                {$i=0}
                                {foreach $speedtests as $single_speedtest}
                                {if $i==0}
                                {literal}
                                {
                                    {/literal}
                                    x: new Date({$single_speedtest->datetime*1000}),
                                    y:{$single_speedtest->getCmccPing()},
                                    label: "中国移動の遅延"
                                    {literal}
                                }
                                {/literal}
                                {$i=1}
                                {else}
                                {literal}
                                , {
                                    {/literal}
                                    x: new Date({$single_speedtest->datetime*1000}),
                                    y:{$single_speedtest->getCmccPing()},
                                    label: "中国移動の遅延"
                                    {literal}
                                }
                                {/literal}
                                {/if}
                                {/foreach}

                            ]
                        }
                    ]
                });


        chart{$id}.render();
        up_chart{$id}.render();
        alive_chart{$id}.render();
        speedtest_ping_chart{$id}.render();


    });


</script>
