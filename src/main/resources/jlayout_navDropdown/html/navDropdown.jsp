<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="baseLevel" value="${currentNode.properties['baseLevel'].long}"/>

<c:forEach items="${jcr:getMeAndParentsOfType(renderContext.mainResource.node, 'jnt:page')}" var="item">
    <c:if test="${item.depth eq baseLevel + 2}">
        <c:set var="root" value="${item}"/>
    </c:if>
</c:forEach>

<c:if test="${not empty root}">
    <c:set var="pages" value="${jcr:getChildrenOfType(root, 'jnt:page')}"/>
    <c:if test="${fn:length(pages) > 0}">
        <div class="btn-group pull-right">
            <c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>

            <button data-toggle="dropdown" class="btn btn-primary btn-nav-level4 dropdown-toggle">
                <c:choose>
                    <c:when test="${! empty title}">${title}</c:when>
                    <c:otherwise><fmt:message key="genericnt_navDropdown.menu"/></c:otherwise>
                </c:choose>&nbsp;<span class="caret"></span></button>
            <ul class="dropdown-menu">
                <c:forEach items="${pages}" var="page" varStatus="status">
                    <li><a href="${page.url}"><i class="fa fa-fixed-width fa-file-o"></i>${page.displayableName}
                    </a></li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
</c:if>