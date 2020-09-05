<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="analyze.aspx.cs" Inherits="BS_Clinic.analyze" %>

<!DOCTYPE html>

<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>BS-Clinic | تحليل الحالة الصحية</title>
    <link rel="icon" href="img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <!-- themify CSS -->
    <link rel="stylesheet" href="css/themify-icons.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="css/flaticon.css">
    <!-- magnific popup CSS -->
    <link rel="stylesheet" href="css/magnific-popup.css">
    <!-- nice select CSS -->
    <link rel="stylesheet" href="css/nice-select.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="css/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <form id="form1" runat="server">
        <!--::header part start::-->
        <header class="main_menu">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-12">
                        <nav class="navbar navbar-expand-lg navbar-light">
                            <a class="navbar-brand" href="index.html">
                                <img src="img/logo.png" alt="logo">
                            </a>
                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>

                            <div class="collapse navbar-collapse main-menu-item justify-content-end" id="navbarSupportedContent">
                                <ul class="navbar-nav align-items-center">
                                    <li class="nav-item active">
                                        <a class="nav-link" href="index.aspx">الرئيسية</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="appointment.aspx">المواعيد</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="contact.aspx">التواصل</a>
                                    </li>
                                    <li class="nav-item">
                                        <asp:LinkButton ID="btn_signout" runat="server" CssClass="nav-link" OnClick="Sign_out">تسجيل خروج</asp:LinkButton>
                                    </li>
                                    <li class="nav-item">
                                        <p>الإسعاف 2444444 </p>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </header>
        <!-- Header part end-->

        <!-- breadcrumb start-->
        <section class="breadcrumb breadcrumb_bg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb_iner">
                            <div class="breadcrumb_iner_item text-right">
                                <h2>تحليل الحالة الصحية </h2>
                                <p>الرئيسية<span>/</span>المواعيد<span>/</span>تحليل الحالة الصحية</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- breadcrumb start-->

        <!--::doctor_part start::-->
        <section class="doctor_part section_padding single_doctor_part" dir="rtl">
            <div class="container">
                <div style="background-image: url(./img/report.jpg); background-size: cover; background-repeat: no-repeat; background-position: center;">
                    <div style="background: linear-gradient(to right,#fff0,#fff 75%);">
                        <h2 class="text-center">نتيجة التحليل الآلي</h2>
                        <hr />
                        <div runat="server" id="stat" class="text-right" style="font-size:17px;">
                            <p>الاسم: </p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=name %><br /><br />
                            <p>الوزن: </p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=weight %> KG<br /><br />
                            <p>العمر: </p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=age %> سنة <br /><br />
                            <p>نسبة سكر الدم: </p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=suger %> mg/dl <br /><br />
                            <p>النتيجة الآلية: </p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=res %> <br /><br />

                        </div>
                        <div id="deb" runat="server"></div>
                    </div>
                </div>
            </div>
        </section>
        <!--::doctor_part end::-->
    </form>
    <!-- footer part start-->
    <footer class="footer-area">

        <div class="copyright_part">
            <div class="container">
                <div class="row align-items-center">
                    <p class="footer-text text-center m-0 col-lg-8 col-md-12">
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        made with <i class="ti-heart" aria-hidden="true"></i> by <br /> Dyana Al-Jajeh - Abeer Attal Othmanly - Nourulhuda Al-Halabi - Nour Al-Akhras - Nour Hadeed - Sara Sabsabi
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </p>
                    <div class="col-lg-4 col-md-12 text-center text-lg-right footer-social">
                        <a href="#"><i class="ti-facebook"></i></a>
                        <a href="#"><i class="ti-twitter"></i></a>
                        <a href="#"><i class="ti-instagram"></i></a>
                        <a href="#"><i class="ti-skype"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- footer part end-->

    <!-- jquery plugins here-->

    <script src="js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- easing js -->
    <script src="js/jquery.magnific-popup.js"></script>
    <!-- swiper js -->
    <script src="js/swiper.min.js"></script>
    <!-- swiper js -->
    <script src="js/masonry.pkgd.js"></script>
    <!-- particles js -->
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <!-- swiper js -->
    <script src="js/slick.min.js"></script>
    <script src="js/jquery.counterup.min.js"></script>
    <script src="js/waypoints.min.js"></script>
    <!-- contact js -->
    <script src="js/jquery.ajaxchimp.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script src="js/mail-script.js"></script>
    <script src="js/contact.js"></script>
    <!-- custom js -->
    <script src="js/custom.js"></script>
</body>
</html>
