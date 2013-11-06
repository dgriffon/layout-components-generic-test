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

<c:forEach items="${jcr:getParentsOfType(renderContext.mainResource.node, 'jnt:page')}" var="item">
    <c:if test="${item.depth eq baseLevel + 2}">
        <c:set var="root" value="${item}"/>
    </c:if>
</c:forEach>

<c:if test="${not empty root}">
    <c:set var="siblings" value="${jcr:getChildrenOfType(root, 'jnt:page')}"/>
    <c:if test="${fn:length(siblings) > 1}">
        <c:forEach items="${siblings}" var="sibling" varStatus="status">
            <c:if test="${renderContext.mainResource.node eq sibling}">
                <c:if test="${not status.first}">
                    <c:set var="previousPage" value="${siblings[status.index - 1]}"/>
                </c:if>
                <c:if test="${not status.last}">
                    <c:set var="nextPage" value="${siblings[status.index + 1]}"/>
                </c:if>
            </c:if>
        </c:forEach>

        <ul class="pager">
            <li class="previous ${empty previousPage ? 'disabled' : ''}"><a href="${previousPage.url}">&#8592;
                <fmt:message key="genericnt_navSiblings.previous"/> </a></li>
            <li class="next ${empty nextPage ? 'disabled' : ''}"><a href="${nextPage.url}"><fmt:message
                    key="genericnt_navSiblings.next"/> &#8594;</a></li>
        </ul>
    </c:if>
</c:if>