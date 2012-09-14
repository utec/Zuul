<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="bootstrap" tagdir="/WEB-INF/tags/bootstrap" %>
<%@ taglib prefix="zfn" uri="/WEB-INF/tags/functions.tld" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><decorator:title/> | Zuul</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="contextPath" content="${pageContext.request.contextPath}">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/ext/bootstrap-2.1.1/css/bootstrap.min.css"
          type="text/css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/ext/bootstrap-2.1.1/css/bootstrap-responsive.min.css"
          type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" type="text/css">
    <script src="${pageContext.request.contextPath}/assets/ext/jquery-1.7.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/ext/bootstrap-2.1.1/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <decorator:head/>
    <c:set var="selectedTab"><decorator:extractProperty property="meta.tab" default="home"/></c:set>
</head>

<body>
<div class="container">
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <a class="brand" href="${pageContext.request.contextPath}/">Zuul</a>

                <div class="nav-collapse">
                    <ul class="nav">
                        <li class="${selectedTab == 'home' ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/">Home</a>
                        </li>
                        <security:authorize access="hasRole('ROLE_USER')">
                            <li id="settingsMenu" class="dropdown ${selectedTab == 'settings' ? 'active' : ''}">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                    Settings
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a id="create-settings-group"
                                           href="${pageContext.request.contextPath}/settings/create">
                                            <i class="icon-plus"></i>
                                            Create New
                                        </a>
                                    </li>
                                    <li class="divider"></li>
                                </ul>
                            </li>
                            <li id="adminMenu" class="dropdown ${selectedTab == 'admin' ? 'active' : ''}">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                    Administration
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/system/users">
                                            <i class="icon-user"></i>
                                            Users &amp; Roles
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/system/keys">
                                            <i class="icon-lock"></i>
                                            Key Management
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/system/environments">
                                            <i class="icon-folder-open"></i>
                                            Environments
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </security:authorize>
                    </ul>
                    <security:authorize access="isAuthenticated()">
                        <ul class="nav pull-right">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-user"></i>
                                    <security:authentication property="principal.firstName"/>
                                    <security:authentication property="principal.lastName"/>
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/account/profile">
                                            <i class="icon-edit"></i>
                                            My Profile
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/logout">
                                            <i class="icon-off"></i>
                                            Logout
                                        </a>
                                    </li>
                                    <security:authorize access="!hasRole('ROLE_ADMIN')">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/account/permissions">
                                                <i class="icon-ok-sign"></i>
                                                Request Permissions
                                            </a>
                                        </li>
                                    </security:authorize>
                                </ul>
                            </li>
                        </ul>
                    </security:authorize>
                    <security:authorize access="isAnonymous()">
                        <p class="navbar-text pull-right">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary"
                               style="margin-top: 0;">
                                <i class="icon-user icon-white"></i>
                                Login
                            </a>
                        </p>
                    </security:authorize>
                </div>
            </div>
        </div>
    </div>
    <bootstrap:flashAlert/>
    <decorator:body/>
    <hr>

    <footer>
        <ul>
            <li><a href="https://github.com/mcantrell/Zuul/wiki">View the Documentation</a></li>
            <li><a href="https://github.com/mcantrell/Zuul/issues">Request Support &amp; New Features</a></li>
        </ul>
        <span class="label label-warning">Version: ${zfn:applicationVersion(pageContext.servletContext)}</span>
    </footer>
</div>
<security:authorize access="hasRole('ROLE_USER')">
    <script>
        $(function () {
            $("#settingsMenu .dropdown-menu").settingsMenu();
        });
    </script>
</security:authorize>

</body>
</html>
