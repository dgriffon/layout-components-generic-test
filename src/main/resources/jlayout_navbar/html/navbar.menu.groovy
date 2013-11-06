import org.apache.taglibs.standard.functions.Functions
import org.jahia.services.content.JCRContentUtils
import org.jahia.services.render.RenderService
import org.jahia.services.render.Resource
import org.jahia.taglibs.jcr.node.JCRTagUtils

baseline = currentNode.properties['j:baselineNode']
maxDepth = 2;

startLevelValue = 0

def printMenu;
printMenu = { node, navMenuLevel, omitFormatting ->
    //if (navMenuLevel == 1) {
    //    print("<div class=\"wrapper-menu_principal\">");
    //}

    firstEntry = true;

    if (node) {
        children = JCRContentUtils.getChildrenOfType(node, "jmix:navMenuItem")
        def nbOfChilds = children.size();
        def ulIsOpen = false;
        boolean firstUlOpen = false;
        children.eachWithIndex() { menuItem, index ->
            if (! menuItem.isNodeType("genericmix:hidePage")) {
                itemPath = menuItem.path;
                correctType = true
                if (menuItem.isNodeType("jmix:navMenu")) {
                    correctType = false
                }
                if (menuItem.properties['j:displayInMenu']) {
                    correctType = false
                    menuItem.properties['j:displayInMenu'].each() {
                        correctType |= (it.node.identifier == currentNode.identifier)
                    }
                }
                if (correctType) {
                    hasChildren = navMenuLevel < maxDepth && JCRTagUtils.hasChildrenOfType(menuItem, "jnt:page,jnt:nodeLink,jnt:externalLink")
                    //listItemCssClass = (hasChildren ? "hasChildren" : "noChildren") + (inpath ? " inpath" : "") + (selected ? " selected" : "") + (index == 0 ? " first" : "") + (index == nbOfChilds - 1 ? " lastInLevel" : "");
                    Resource resource = new Resource(menuItem, "html", "menuElement-dropdown", currentResource.getContextConfiguration());

                    def render = "";
                    if (!menuItem.isNodeType("jnt:navMenuText")) {
                        render = RenderService.getInstance().render(resource, renderContext)
                    } else {
                        print "<li class=\"divider\"></li>\n";
                    }
                    if (render != "") {
                        inpath = renderContext.mainResource.node.path == itemPath || renderContext.mainResource.node.path.startsWith(itemPath + "/");
                        inpath2 = renderContext.mainResource.node.path == itemPath || renderContext.mainResource.node.path.startsWith(menuItem.parent.path);
                        selected = menuItem.isNodeType("jmix:nodeReference") ?
                            renderContext.mainResource.node.path == menuItem.properties['j:node'].node.path :
                            renderContext.mainResource.node.path == itemPath;
                        ul = "";
                        listItemCssClass = "class =\"" +(inpath || selected ? " active " : "") + (hasChildren && navMenuLevel > 1 ? "dropdown-submenu" : "dropdown") + "\"";
                        if (navMenuLevel == 1) {
                            if (firstEntry && !firstUlOpen) {
                                ul = "\t\t<ul class=\"nav pull-right\">\n"
                                firstUlOpen = true;
                            }
                            description = menuItem.properties['jcr:description']
                            linkTitle = description ? " title=\"${description.string}\"" : ""

                            link = menuItem.url
                            if (hasChildren) {
                                title = menuItem.displayableName
                                if (menuItem.hasProperty("alternateTitle")) {
                                    title = menuItem.getProperty("alternateTitle").string
                                }
                                ul +="\t\t\t<li ${listItemCssClass}><a class=\"dropdown-toggle\" data-hover=\"dropdown\" data-delay=\"500\"" +
                                        " href=\"${link}\">"+ menuItem.displayableName + "<span" +
                                        " class=\"caret\"></span></a>\n" +
                                        " \t\t\t\t<ul class=\"dropdown-menu\">\n" +
                                        " \t\t\t\t\t<li><a href=\"${link}\"${linkTitle}><i class=\"fa fa-fixed-width fa-arrow-right\"></i> "+ title + "</a>\n" +
                                        " \t\t\t\t\t</li>\n" +
                                        " \t\t\t\t\t<li class=\"divider\"></li>\n"
                                ulIsOpen = true;
                            } else {
                                ul +="<li ${listItemCssClass}><a href=\"${link}\"${linkTitle}> "+ menuItem.displayableName + "</a></li>\n"
                            }
                            print ul
                        } else {
                            tabIndex = ""
                            if (firstEntry && navMenuLevel > 2) {
                                print "<ul class=\"dropdown-menu\">"
                                firstUlOpen = true;
                                tabIndex = "tabindex=\"-1\""
                            }
                            print "\t\t\t\t\t<li ${tabIndex} ${listItemCssClass}>\n";
                            print "\t\t\t\t\t\t" + render + "\n"

                        }
                    }
                    if (hasChildren) {
                        printMenu(menuItem, navMenuLevel + 1, true)
                    }
                    if (render != "" && !ulIsOpen) {
                        print "\t\t\t\t\t</li>\n"
                        firstEntry = false;
                    }
                }
                if (ulIsOpen) {
                    print("</ul></li>")
                }
                if (firstUlOpen && index == nbOfChilds - 1) {
                    print ("</ul>")
                }
            }
        }
    }

    //if (navMenuLevel == 1) {
    //   print("</div>");
    //}

}
printMenu(currentNode.resolveSite.home, 1, false)