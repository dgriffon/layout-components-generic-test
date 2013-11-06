<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<jcr:nodeProperty var="logo" node="${currentNode.resolveSite}" name="logo"/>
<div class="navbar-inner">
    <a class="brand" href="<c:url value='${url.base}${renderContext.site.home.path}.html'/>">
        <c:if test="${renderContext.site.home.path eq renderContext.mainResource.node.path}">
            <h1 class="h1-home"><span>Jahia</span></h1>

            <h2 class="h2-home"><span>Next Generation Open Source CMS</span></h2>
        </c:if>
       <c:if test="${!empty logo.node}">
           <img src="<c:url value='${logo.node.url}' context='/'/>" alt="${logo.node.displayableName}"/>
       </c:if>
        <span>${currentNode.resolveSite.properties["baseline"].string}</span>
    </a>
    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
            class="nb_left pull-left"> <span class="fa fa-bar"></span> <span
            class="fa fa-bar"></span> <span
            class="fa fa-bar"></span></span> <span class="nb_right pull-right">menu</span>
    </a>

    <div class="nav-collapse collapse">
        <c:choose>
            <c:when test="${fn:startsWith(renderContext.mainResource.path,'/modules/')}">
               <%-- sample code for studio only--%>
            <ul class="nav pull-right">
                <li class="active dropdown"><a data-toggle="dropdown" class="dropdown-toggle" href="#">Product<span
                        class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#"><i class="fa fa-fixed-width fa-arrow-right"></i> Product Link </a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="#"><i class="fa fa-fixed-width fa-file-o"></i> Content
                            Management</a></li>
                        <li><a href="#"><i class="fa fa-fixed-width fa-file-o"></i> Mobile</a></li>
                        <li><a href="#"><i class="fa fa-fixed-width fa-file-o"></i> System
                            information</a></li>
                    </ul>
                </li>
                <li class="dropdown"><a data-toggle="dropdown" class="dropdown-toggle"
                                        href="#">Solutions<span
                        class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#"><i class="fa fa-fixed-width fa-arrow-right"></i> Solutions Link
                        </a></li>
                        <li class="divider"></li>
                        <li><a href="#"><i class="fa fa-fixed-width fa-file-o"></i> Content
                            Management</a></li>
                        <li><a href="#"><i class="fa fa-fixed-width fa-file-o"></i> System
                            information</a></li>
                    </ul>
                </li>
                <li class="dropdown"><a data-toggle="dropdown" class="dropdown-toggle"
                                        href="#">Services<span
                        class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#"><i class="fa fa-fixed-width fa-arrow-right"></i> Services Link </a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="#"><i class="fa fa-fixed-width fa-file-o"></i> Content
                            Management</a></li>
                        <li><a href="#"><i class="fa fa-fixed-width fa-file-o"></i> Mobile</a></li>
                    </ul>
                </li>
            </ul>
            </c:when>
            <c:otherwise><template:module node="${currentNode}" view="menu"/></c:otherwise>
        </c:choose>
    </div>
</div>