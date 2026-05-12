---
title: "ICCOA 数字车钥匙 4.0 — 蓝牙协议解读与实现方案"
description: ""
date: 2026-04-13T19:13:18+08:00
categories: ["技术文档"]
tags: []
draft: false
---

<iframe src="/blog/posts/ICCOA-DK4-蓝牙流程描述.html" style="width:100%;height:100vh;border:none;overflow:hidden" onload="this.style.height=this.contentWindow.document.body.scrollHeight+'px'"></iframe>
<script>
document.querySelector('iframe').addEventListener('load',function(){
    var i = this;
    try {
        var h = i.contentWindow.document.body.scrollHeight;
        i.style.height = h + 'px';
        // Listen for resize
        new ResizeObserver(function(){
            i.style.height = i.contentWindow.document.body.scrollHeight + 'px';
        }).observe(i.contentWindow.document.body);
    } catch(e) {
        i.style.height = '8000px';
    }
});
</script>