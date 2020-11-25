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

<template:addResources type="javascript" resources="newsFilter.js"/>
<template:addResources type="javascript" resources="isotope.pkgd.js"/>

<c:set var="siteNode" value="${renderContext.site}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<jcr:nodeProperty node="${currentNode}" name="bannerText" var="bannerText"/>
<jcr:nodeProperty node="${currentNode}" name="maxItems" var="maxItems"/>
<jcr:nodeProperty node="${currentNode}" name="filter" var="topFilter"/>
<jcr:nodeProperty node="${currentNode}" name='j:startNode' var="startNode"/>
<jcr:nodeProperty node="${currentNode}" name='j:criteria' var="criteria"/>
<jcr:nodeProperty node="${currentNode}" name='j:sortDirection' var="sortDirection"/>
<jcr:nodeProperty node="${currentNode}" name='j:type' var="type"/>
<jcr:nodeProperty node="${currentNode}" name="j:catFilters" var="catFilters"/>
<jcr:nodeProperty node="${currentNode}" name="j:catNoFilters" var="catNoFilters"/>
<jcr:nodeProperty node="${currentNode}" name="j:selectedCat" var="selectedCat"/>
<jcr:nodeProperty node="${currentNode}" name="j:subNodesView" var="subNodesView"/>

<c:if test="${not empty startNode}">
    <c:set var="startNode" value="${startNode.node}"/>
</c:if>
<c:if test="${empty startNode}">
    <c:set var="startNode" value="${jcr:getMeAndParentsOfType(renderContext.mainResource.node, 'jnt:page')[0]}"/>
</c:if>
<%-- get the child items --%>
<jcr:jqom var="listQuery"
          limit="${currentResource.moduleParams.queryLoadAllUnsorted == 'true' ? -1 : maxItems.long}">
    <query:selector nodeTypeName="${type.string}"/>
    <query:descendantNode path="${startNode.path}"/>
    <query:or>
        <c:forEach var="filter" items="${catFilters}">
            <c:if test="${not empty filter.string}">
                <query:equalTo propertyName="j:defaultCategory" value="${filter.string}"/>
            </c:if>
        </c:forEach>
    </query:or>
    <query:and>
        <query:or>
            <c:forEach var="noFilter" items="${catNoFilters}">
                <c:if test="${not empty noFilter.string}">
                    <query:notEqualTo propertyName="j:defaultCategory" value="${noFilter.string}"/>
                </c:if>
            </c:forEach>
        </query:or>
    </query:and>
    <c:if test="${not currentResource.moduleParams.queryLoadAllUnsorted == 'true'}">
        <query:sortBy propertyName="${criteria.string}" order="${sortDirection.string}"/>
    </c:if>
</jcr:jqom>
<c:if test="${not empty selectedCat}">
    <c:set value="${selectedCat[0].node.name}" var="selectedCat"/>
</c:if>
<c:if test="${empty selectedCat}">
    <c:set value="*" var="selectedCat"/>
</c:if>
<!-- Portfolio Grid Section -->
<div class="animate-grid">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2 class="section-heading">${title}</h2>
                <h3 class="section-subheading text-muted">${bannerText}</h3>
            </div>
        </div>
        <c:if test="${topFilter.string ne 'None'}">
            <div class="row">
                <div class="col-xs-12 w-100">
                    <div class="blog-refinement-bar ">
                        <div class="folder-refinement-container categories">
                            <div class="blog-refinement">
                                <div class="refinement-item">
                                    <a class="refinement-link ${selectedCat == '*'? ' active' : ''}" href="#"
                                       data-filter="*">All</a>
                                </div>
                                <c:if test="${topFilter.string == 'Categories' or topFilter.string == 'Both'}">
                                    <script language="JavaScript">
                                        var activeItem = "";
                                        var categories = [];
                                        <c:forEach items="${listQuery.nodes}" var="objects" varStatus="status">
                                        <jcr:nodeProperty node="${objects}" var="objCategories" name="j:defaultCategory"/>
                                        <c:if test="${!empty objCategories}">
                                        <c:forEach items="${objCategories}" var="category">
                                        categories.push("${category.node.name}");
                                        </c:forEach>
                                        </c:if>
                                        </c:forEach>
                                        var uniqueCategories = [];
                                        $.each(categories, function (i, el) {
                                            if ($.inArray(el, uniqueCategories) === -1) uniqueCategories.push(el);
                                        });

                                        for (var j = 0; j < uniqueCategories.length; j++) {
                                            var res = uniqueCategories[j].replace(/-/g, " ");
                                            if ('${selectedCat}' == uniqueCategories[j]) {
                                                activeItem = " active";
                                            }
                                            document.write('<div  class="refinement-item"><a class="refinement-link ' + activeItem + '" href="#" data-filter=".' + uniqueCategories[j] + '">' + res + '</a></div>');
                                            activeItem = "";
                                        }
                                    </script>
                                </c:if>
                                <c:if test="${topFilter.string == 'Tags' or topFilter.string == 'Both'}">
                                    <script language="JavaScript">
                                        var tags = [];
                                        <c:forEach items="${listQuery.nodes}" var="objects" varStatus="status">
                                        <jcr:nodeProperty node="${objects}" var="objTags" name="j:tagList"/>
                                        <c:if test="${!empty objTags}">
                                        <c:forEach items="${objTags}" var="tag">
                                        tags.push("${tag.string}");
                                        </c:forEach>
                                        </c:if>
                                        </c:forEach>
                                        var uniqueTags = [];
                                        $.each(tags, function (i, el) {
                                            if ($.inArray(el, uniqueTags) === -1) uniqueTags.push(el);
                                        });

                                        for (var j = 0; j < uniqueTags.length; j++) {
                                            document.write('<div  class="refinement-item"><a class="refinement-link" href="#" data-filter=".' + uniqueTags[j] + '">' + uniqueTags[j] + '</a></div>');
                                        }
                                    </script>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <div class="row gallary-thumbs">
            <c:forEach items="${listQuery.nodes}" var="objects" varStatus="status">
                <template:module node="${objects}" view="${subNodesView.string}"/>
            </c:forEach>
        </div>
    </div>
</div>
<script>
<c:if test="${selectedCat.toString() ne '*'}">
    <c:set var="isoFilter" value=".${selectedCat}"/>
</c:if>

    $(window).load(function () {
        var $container = $('.animate-grid .gallary-thumbs');
        $container.isotope({
            filter: '${isoFilter}',
            transitionDuration: '0.6s',
        });
        $('.animate-grid .categories a').click(function () {
            $('.animate-grid .categories .active').removeClass('active');
            $(this).addClass('active');
            var selector = $(this).attr('data-filter');
            $container.isotope({
                filter: selector
            });
            return false;
        });
    });
</script>
