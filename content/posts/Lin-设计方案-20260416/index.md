---
title: "LIN 通信设计参考手册"
description: ""
date: 2026-04-16T11:16:12+08:00
categories: ["技术文档"]
tags: []
draft: false
---

<iframe src="/blog/posts/Lin-设计方案-20260416.html" style="width:100%;height:100vh;border:none;overflow:hidden" onload="this.style.height=this.contentWindow.document.body.scrollHeight+'px'"></iframe>
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