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

<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<%--<template:addResources type="css" resources="bootstrap.min.css" />--%>
<%--<template:addResources type="javascript" resources="jquery.min.js,popper.min.js,bootstrap.min.js"/>--%>
<c:set var="bindedComponent" value="${ui:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>
<c:if test="${not empty bindedComponent && jcr:isNodeType(bindedComponent, 'viant:experience, viant:heading')}">
    <c:set var="targetProps" value="${bindedComponent.properties}"/>
</c:if>
<c:set var="title" value="${targetProps['vendorName'].string}"/>
<c:set var="image" value="${targetProps['backgroundImage']}"/>
<c:set var="categories" value="${targetProps['j:defaultCategory']}"/>



<div class="inner-page">
    <div class="slider-item" style="background-image: url('${image.node.url}');">
        <div class="container">
            <div class="row slider-text align-items-center justify-content-center">
                <div class="col-md-12 text-center col-sm-12 pt-5 element-animate">
                    <%-- --%>
                    <h1 class="pt-5">${title}</h1>
                 
                        <c:if test="${categories != null}">
                            <c:forEach items="${categories}" var="category">
                                <i class="fa fa-tag" aria-hidden="true"></i>  <span class="categorytitle mr-3">${category.node.displayableName} </span>                            </c:forEach>

                        </c:if>
                </div>
            </div>
        </div>
    </div>
</div>