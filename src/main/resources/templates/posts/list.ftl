<#include "../layout/layout.ftl"/>
<#include "../layout/pagination.ftl"/>
<#include "./sidebar.ftl"/>
<@compress single_line=true>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN" dir="ltr" prefix="og: http://ogp.me/ns#">
    <@head headVO,title>

    </@head>
    <body>
    <@header headerVO>

    </@header>
    <div class="container" style="padding-top: 50px;">
        <h3>${catTitle!"全部文档"}</h3>
        <hr>
        <div class="row">
            <div class="col-xl-9 col-lg-9 col-md-8">
                <div class="d-none d-sm-block mb-3">
                    <@adsense "6116570539" active></@adsense>
                </div>
                <#if enName??>
                    <#if enName == 'share'>
                        <div class="alert alert-info" role="alert">
                            社区分享已经上线：<a href="https://bbs.renfei.net/forum-41-1.html" target="_blank">https://bbs.renfei.net/forum-41-1.html</a>
                        </div>
                    </#if>
                </#if>
                <#if lists?? && (lists?size>0)>
                    <#list lists as post>
                        <div class="card mb-3" style="margin-bottom: 1rem;">
                            <div class="row no-gutters">
                                <div class="col-xl-4">
                                    <img src="${post.featuredImage!}?x-oss-process=style/992.558"
                                         class="card-img" alt="${post.title}" width="992px" height="558px" style="width: 100%;height: auto;">
                                </div>
                                <div class="col-xl-8">
                                    <div class="card-body" style="padding: 0.2rem 1.25rem;">
                                        <small class="text-muted">${post.releaseTime?string("yyyy-MM-dd")!}</small>
                                        <a class="stretched-link" href="/posts/${post.id?c}" style="color: #000000;">
                                            <h5 class="card-title" style="font-size: 17px;">
                                                <#if (post.title)?length lt 30>
                                                    ${post.title!}
                                                <#else>
                                                    ${(post.title)?substring(0,30)}...
                                                </#if>
                                            </h5>
                                        </a>
                                        <p class="card-text">
                                            <#if (post.describes!)?length lt 50>
                                                ${post.describes!}
                                            <#else>
                                                ${(post.describes!)?substring(0,50)}...
                                            </#if>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#list>
                </#if>
                <div class="d-none d-sm-block mb-3">
                    <@adsense "3646319863" active></@adsense>
                </div>
                <@paginationLayout paginationList></@paginationLayout>
            </div>
            <div class="col-xl-3 col-lg-3 col-md-4">
                <@sidebar PostSidebar></@sidebar>
            </div>
        </div>
    </div>
    <@footer footerVO performance_execTimeTotal performance_execCountTotal>

    </@footer>
    </body>
    </html>
</@compress>