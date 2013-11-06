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
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="baseLevel" value="${currentNode.properties['baseLevel'].long}"/>

<c:forEach items="${jcr:getMeAndParentsOfType(renderContext.mainResource.node, 'jnt:page')}" var="item">
    <c:if test="${item.depth eq baseLevel + 2}">
        <c:set var="root" value="${item}"/>
    </c:if>
</c:forEach>

<c:if test="${not empty root}">
    <c:set var="pages" value="${jcr:getChildrenOfType(root, 'jnt:page')}"/>
    <c:if test="${fn:length(pages) > 0}">
        <div class="well well-white">
            <c:if test="${! empty title}">
                <p><strong>${title}</strong></p>
            </c:if>
            <div class="row-fluid">
                <div class="span6">
                    <ul class="fa-ul">
                        <c:forEach items="${pages}" var="page" varStatus="status">
                            <c:if test="${status.index % 2 == 0}">
                                <c:choose>
                                    <c:when test="${page.path == renderContext.mainResource.node.path}">
                                        <li><i class="fa fa-file"></i> <a
                                                href="${page.url}"><strong>${page.displayableName}</strong></a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><i class="fa fa-file-o"></i> <a
                                                href="${page.url}">${page.displayableName}</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <div class="span6">
                    <ul class="fa-ul">
                        <c:forEach items="${pages}" var="page" varStatus="status">
                            <c:if test="${status.index % 2 == 1}">
                                <c:choose>
                                    <c:when test="${page.path == renderContext.mainResource.node.path}">
                                        <li><i class="fa fa-file"></i> <a
                                                href="${page.url}"><strong>${page.displayableName}</strong></a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><i class="fa fa-file-o"></i> <a
                                                href="${page.url}">${page.displayableName}</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </c:if>
</c:if>
