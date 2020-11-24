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
<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="carouselId" value="carousel-${rand}"/>

<jcr:nodeProperty node="${currentNode}" name="backgroundImage" var="backgroundImage"/>
<jcr:nodeProperty node="${currentNode}" name="images" var="teaserImages"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="name"/>
<jcr:nodeProperty node="${currentNode}" name="description" var="description"/>
<jcr:nodeProperty node="${currentNode}" name="vendorName" var="vendorName"/>

<c:if test="${not empty backgroundImage}">
    <jahia:addCacheDependency node="${backgroundImage.node}"/>
    <c:url value="${url.files}${backgroundImage.node.path}" var="backgroundImageUrl"/>
</c:if>

<c:if test="${not empty teaserImages}">
    <jahia:addCacheDependency node="${teaserImages[0].node}"/>
    <c:url value="${url.files}${teaserImages[0].node.path}" var="teaserImageUrl"/>
</c:if>


<div class="preview mb-5">
    <div class="wrap">
        <div class="contents">
            <h1>${vendorName}</h1>
            <div>${description}</div>
        </div>
    </div>
    <div id="${carouselId}" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <c:forEach items="${teaserImages}" var="image" varStatus="status">
                <li data-target="#${carouselId}" data-slide-to="${status.index}"
                    class="${status.first?' active':''}"></li>
            </c:forEach>
        </ol>
        <div class="carousel-inner mt-2">
            <c:forEach items="${teaserImages}" var="image" varStatus="status">
                <div class="carousel-item ${status.first?' active':''}">
                    <img class="d-block w-100 px-5" src="${image.node.url}" alt="${image.node.name}">
                </div>
            </c:forEach>
            <a class="carousel-control-prev" href="#${carouselId}" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#${carouselId}" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
</div>

