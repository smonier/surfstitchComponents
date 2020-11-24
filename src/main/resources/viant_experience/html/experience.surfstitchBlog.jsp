<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="jahia" uri="http://www.jahia.org/tags/templateLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="siteNode" value="${renderContext.site}"/>
<jcr:nodeProperty node="${currentNode}" name="backgroundImage" var="backgroundImage"/>
<jcr:nodeProperty node="${currentNode}" name="images" var="teaserImages"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="name"/>
<jcr:nodeProperty node="${currentNode}" name="description" var="description"/>
<jcr:nodeProperty node="${currentNode}" name="vendorName" var="vendorName"/>
<jcr:nodeProperty node="${currentNode}" var="xpCategories" name="j:defaultCategory"/>
<jcr:nodeProperty node="${currentNode}" name="j:tagList" var="xpTags"/>

<c:if test="${not empty backgroundImage}">
    <jahia:addCacheDependency node="${backgroundImage.node}"/>
    <c:url value="${url.files}${backgroundImage.node.path}" var="backgroundImageUrl"/>
</c:if>

<c:if test="${not empty teaserImages}">
    <jahia:addCacheDependency node="${teaserImages[0].node}"/>
    <c:url value="${url.files}${teaserImages[0].node.path}" var="teaserImageUrl"/>
</c:if>

<c:set var="myCat" value=""/>
<c:if test="${!empty xpCategories }">
    <c:forEach items="${xpCategories}" var="category">
        <c:set var="myCat" value="${myCat} ${category.node.name}"/>
    </c:forEach>
</c:if>
<c:set var="myTags" value=""/>
<c:if test="${!empty xpTags }">
    <c:forEach items="${xpTags}" var="tag">
        <c:set var="myTags" value="${myTags} ${tag.string}"/>
    </c:forEach>
</c:if>
<div class="blog mb-5 col-xs-4 ${myCat} ${myTags}">
    <div class="blog-wrapper">
        <div class="img-blog ">
            <a href="${url.base}${currentNode.path}.html?jsite=${siteNode.UUID}">
                <img src="${backgroundImageUrl}" alt="${name}">
            </a>
        </div>
        <div class="content-blog">
            <div class="tag-outer">
                <div class="tag">
                    <img alt="All"
                         src="${url.currentModule}/images/all-icon@2x.png">
                </div>
            </div>
            <h2 class="blog-title">${vendorName}</h2>
            <div>
                <p class="description-blog">${functions:abbreviate(functions:removeHtmlTags(description),400,450,'...')}</p>
            </div>
            <a href="${url.base}${currentNode.path}.html?jsite=${siteNode.UUID}" class="read-more">Read More</a>
        </div>
    </div>
</div>