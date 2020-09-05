<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Appointment.aspx.cs" Inherits="BS_Clinic.Appointment" EnableEventValidation="false"%>

<!doctype html>
<html lang="ar">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>BS-Clinic | المواعيد</title>
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
                                        <asp:LinkButton runat="server" CssClass="nav-link" OnClick="Sign_out">تسجيل خروج</asp:LinkButton>
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
                                <h2>المواعيد</h2>
                                <p>الرئيسية<span>/</span>المواعيد</p>
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
                <div class="row">
                    <div id="res" runat="server">
                    </div>
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="nav flex-column nav-pills col-sm-3 text-right" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                <a class="nav-link active" id="v-pills-booking-tab" data-toggle="pill" href="#v-pills-booking" role="tab" aria-controls="v-pills-booking" aria-selected="true">حجز أو حذف موعد</a>
                                <a class="nav-link" id="v-pills-view-tab" data-toggle="pill" href="#v-pills-view" role="tab" aria-controls="v-pills-view" aria-selected="false">استعراض المواعيد السابقة</a>
                                <%if (bol)
                                   { %>
                                <a class="nav-link" id="v-pills-res-tab" data-toggle="pill" href="#v-pills-res" role="tab" aria-controls="v-pills-res" aria-selected="false">تحديد نتيجة فحص</a>
                                <br />
                               <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" CssClass="nice-select"></asp:DropDownList>
                                <br />
                                    <asp:LinkButton ID="btn_clear" runat="server" CssClass="btn btn-outline-primary" OnClick="Btn_clear_Click">تفريغ جدول مواعيد الأسبوع</asp:LinkButton>
                                <%} %>
                            </div>
                            <div class="tab-content col-sm-9" id="v-pills-tabContent">
                                <div class="tab-pane fade show active " id="v-pills-booking" role="tabpanel" aria-labelledby="v-pills-booking-tab">
                                    <div class="table-responsive">
                                        <table class="table table-hover text-center">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th scope="col">@</th>
                                                    <th scope="col">السبت</th>
                                                    <th scope="col">الأحد</th>
                                                    <th scope="col">الاثنين</th>
                                                    <th scope="col">الثلاثاء</th>
                                                    <th scope="col">الاربعاء</th>
                                                    <th scope="col">الخميس</th>
                                                </tr>
                                            </thead>
                                            <tbody id="bdy" runat="server">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="v-pills-res" role="tabpanel" aria-labelledby="v-pills-res-tab">
                                    <div class="table-responsive">
                                        <table class="table table-hover text-center">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th scope="col">@</th>
                                                    <th scope="col">السبت</th>
                                                    <th scope="col">الأحد</th>
                                                    <th scope="col">الاثنين</th>
                                                    <th scope="col">الثلاثاء</th>
                                                    <th scope="col">الاربعاء</th>
                                                    <th scope="col">الخميس</th>
                                                </tr>
                                            </thead>
                                            <tbody id="set" runat="server">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="v-pills-view" role="tabpanel" aria-labelledby="v-pills-view-tab">
                                    <div class="table-responsive">
                                        <table class="table table-hover text-center">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th scope="col">@</th>
                                                    <th scope="col">اسم المريض</th>
                                                    <th scope="col">تاريخ الموعد</th>
                                                    <th scope="col">الوقت</th>
                                                    <th scope="col">نتيجة الفحص</th>
                                                    <th scope="col">رقم الوصفة</th>
                                                    <th scope="col">تحليل آلي</th>
                                                </tr>
                                            </thead>
                                            <tbody id="old" runat="server">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>

                        <asp:AsyncPostBackTrigger ControlID="DropDownList1" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="btn_clear" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
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
