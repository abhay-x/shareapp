<%@ page import="in.shareapp.user.entity.User" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <!-- CSS File -->
    <link rel="stylesheet" href="./css/index.css"/>
    <link rel="stylesheet" href="./css/Modal.css">
    <link rel="stylesheet" href="./css/loginDetailModal.css">
    <%-- Jquery CDN--%>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"
            integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <title>ShareApp</title>
</head>
<body>
<%-- NavBar --%>
<header class="header">
    <!-- Sidebar toggle btn && home/App logo -->
    <div class="logo left">
        <img onclick="toggleNav()" src="./images/icons/menu.svg" alt="C"
             style="width:30px; height:30px; viewBox:0 0 60 60">
        <a href="http://localhost:8080/shareapp">ShareApp</a>
    </div>

    <!-- Search bar -->
    <div class="search center">
        <form action="/search" method="post">
            <input type="text" placeholder="Search"/>
            <button><img onclick="searchApp()" src="./images/icons/search.svg" alt="C"
                         style="width:30px; height:30px; viewBox:0 0 60 60"></button>
        </form>
        <img onclick="mic()" src="./images/icons/mic.svg" alt="C" style="width:30px; height:30px; viewBox:0 0 60 60">
    </div>

    <!-- Right section (user/signin/signup/signout) -->
    <div class="icons right">
        <%
            User user = null;
            //session.invalidate();
            if (session.getAttribute("SIGNINSTATUS") == null || session.getAttribute("SIGNINSTATUS").toString().equals("Fail")) {
                System.out.println("SIGNINSTATUS at Index.jsp:" + session.getAttribute("SIGNINSTATUS"));
                System.out.println("USERDETAILS at Index.jsp:" + session.getAttribute("USERDETAILS"));
        %>
        <!-- Trigger/Open The Modal by click on button -->
        <a class="display-this" onclick="loadSignin()" class="login">SignIn</a>
        <%
        } else {
            System.out.println("SIGNINSTATUS at Index.jsp:" + session.getAttribute("SIGNINSTATUS"));
            System.out.println("USERDETAILS at Index.jsp:" + session.getAttribute("USERDETAILS"));

            user = (User) session.getAttribute("USERDETAILS");
        %>
        <img src="./ClientResources/ProfilePics/<%=user.getPhoto()%>" onclick="signinDetails()" alt=""
             style="border-radius: 50%; height: 40px; width: 40px;">

        <!-- The login detail Modal (css in Modal.css)-->
        <div id="loginDetailModal" class="logindetail-container">
            <span class="logindetail-close">CLOSE</span>
            <!-- Modal content -->
            <div class="card">
                <img src="./ClientResources/ProfilePics/<%=user.getPhoto()%>" alt="USER" style="width:100%">
                <p><%=user.getFirstName() + " " + user.getLastName()%>
                </p>
                <a href="javascript:loadProfile()">
                    <button>View Profile</button>
                </a>
                <a href="javascript:signOut()">
                    <button>Sign Out</button>
                </a>
            </div>
        </div>
        <%
            }
        %>
    </div>
</header>

<%
    if(request.getAttribute("PostUpload")!=null){
        String color = "green";
        if (request.getAttribute("PostUpload").equals("fail")){
            color = "red";
        }
%>
        <div style="background: black; display: flex; justify-content: center">
            <p style="color: <%=color%>">
                Post upload: <%= request.getAttribute("PostUpload") %>
                <button onclick="goHome()" style="padding: 5px 15px 5px 15px;">OK</button>
            </p>
        </div>
<%
    }
%>

<!-- The Modal (css in Modal.css)-->
<div id="modal" class="popup-container">
    <!-- Modal content -->
    <div class="popup-box">
        <span class="popup-close">&times;</span>
        <div class="pop-content"></div>
    </div>
</div>

<%-- The Body --%>
<main>
    <!--Left Side Menu Panel-->
    <div class="side-bar">
        <div class="nav">
            <a class="nav-link active" onclick="loadVideos()">
                <img src="./images/icons/videos.svg" alt="C" style="width:30px; height:30px; viewBox:0 0 60 60">
                <span>Videos</span>
            </a>
            <a class="nav-link" onclick="loadAudios()">
                <img src="./images/icons/audio.svg" alt="C" style="width:30px; height:30px; viewBox:0 0 60 60">
                <span>Audio</span>
            </a>
            <a class="nav-link" onclick="loadBlogs()">
                <img src="./images/icons/blog.png" alt="C" style="width:30px; height:30px; viewBox:0 0 60 60">
                <span>Blogs</span>
            </a>
            <a class="nav-link" onclick="loadHistory()">
                <img src="./images/icons/history.svg" alt="C" style="width:30px; height:30px; viewBox:0 0 60 60">
                <span>History</span>
            </a>
            <hr/>
            <%
                if (user != null) {
            %>
            <a class="nav-link" onclick="myPosts()">
                <img src="./images/icons/posts.svg" alt="C" style="width:30px; height:30px; viewBox:0 0 60 60">
                <span>My Posts</span>
            </a>
            <a class="nav-link" onclick="loadLikedItems()">
                <img src="./images/icons/like.svg" alt="C" style="width:30px; height:30px; viewBox:0 0 60 60">
                <span>Liked items</span>
            </a>
            <a class="nav-link" onclick="openPostCreatorWindow()">
                <img src="./images/icons/upload.svg" alt="C" style="width:30px; height:30px; viewBox:0 0 60 60">
                <span>Upload</span>
            </a>
            <hr/>

            <%
                }
            %>
        </div>
    </div>

    <!--Content start-->
    <style type="text/css">   @import url("./css/content.css"); </style>

    <div class="videos">
        <h1>Recommended </h1>
        <div class="videos-container">
            <%-- single video container--%>
            <div class="video">
                <div class="video-thumbnail">
                    <img src="" alt="thumbnail"/>
                </div>

                <div class="video-details">
                    <div class="author">
                        <img src="" alt="author"/>
                    </div>

                    <div class="video-title">
                        <h3>How To COOK?</h3>
                        <a href="">Cooking</a>
                        <span>10M Views . 3 Months Ago</span>
                    </div>
                </div>
            </div>
            <%-- single video container--%>

            <%-- single video container--%>
            <div class="video">
                <div class="video-thumbnail">
                    <img src="" alt="thumbnail"/>
                </div>

                <div class="video-details">
                    <div class="author">
                        <img src="" alt="author"/>
                    </div>

                    <div class="video-title">
                        <h3>How To COOK?</h3>
                        <a href="">Cooking</a>
                        <span>10M Views . 3 Months Ago</span>
                    </div>
                </div>
            </div>
            <%-- single video container--%>
        </div>
    </div>
    <!--Content End-->
</main>

<!-- Scripts -->
<script src="./js/custom.js"></script>
</body>
</html>