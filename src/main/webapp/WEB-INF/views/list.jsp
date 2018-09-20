<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 06.09.2018
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <title>Компьютерные запчасти</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <div class="container" style="margin-bottom: 20px;">
        <h1>Детали для компьютера</h1>
        <div class="table-responsive">
            <form action="/part/search" method="post">
                Искать деталь: <input class="form-control" type="text" name="searchName"/>
                <input type="submit" value="Поиск" class="btn btn-default"/>
            </form>
            <br/>
            <c:url value="/part/filterPerUse" var="useList">
                <c:param name="filterParam" value="use"/>
            </c:url>
            <c:url value="/part/filterPerUse" var="notUseList">
                <c:param name="filterParam" value="notUse"/>
            </c:url>
            <c:url value="/part/list" var="list"/>
            Фильтр: <a class="btn btn-default" href="${list}">Все</a> <a class="btn btn-default"  href="${useList}">Для сборки</a> <a class="btn btn-default" href="${notUseList}">Без сборки</a>
            <table class="table table-hover">
                <thead>
                    <th>Наименование</th>
                    <th>Необходимость</th>
                    <th>Количество</th>
                    <th>Действие</th>
                </thead>
                <tbody>
                <c:forEach var="part" items="${listOfparts}">
                    <c:url var="removePart" value="/part/removePart">
                        <c:param name="partId" value="${part.id}"/>
                    </c:url>

                    <c:url var="updatePart" value="/part/updatePart">
                        <c:param name="partId" value="${part.id}"/>
                    </c:url>
                    <tr>
                        <td id="leftMargin">${part.namePart}</td>
                        <td>
                            <c:if test="${part.isBuild==null}">-</c:if>
                            <c:if test="${part.isBuild!=null}">+</c:if>
                        </td>
                        <td>${part.quantity}</td>
                        <td><a class="btn btn-danger" href="${removePart}">Удалить</a> <a class="btn btn-warning ediforma" href="#" data-id="${part.id}" data-quant="${part.quantity}" data-namtext="${part.namePart}" data-checked="<c:if test="${part.isBuild==null}">0</c:if><c:if test="${part.isBuild!=null}">1</c:if>" data-toggle="modal" data-target="#modaleditpart">Редактировать</a></td>
                    </tr>
                </c:forEach>
                <c:if test="${isCount != null}">
                    <tr>
                        <td>
                            <strong>
                            Можно собрать
                            </strong>
                        </td>
                        <td>${count}</td>
                        <td> <strong>устройств</strong></td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${isPage!=null}">
            <c:choose>

                <c:when test="${currentPage == 1}">
                    <a href="#" class="disabled">В начало</a>
                    <a href="#" class="disabled">Предыдущая</a>
                </c:when>
                <c:otherwise>
                    <c:url var="firstPageLink" value="/part/list">
                        <c:param name="pageNumber" value="1" />
                    </c:url>
                    <a href="${firstPageLink}">В начало</a>

                    <c:url var="prevPageLink" value="/part/list">
                        <c:param name="pageNumber" value="${currentPage - 1}" />
                    </c:url>
                    <a href="${prevPageLink}">Предыдущая</a>
                </c:otherwise>

            </c:choose>


            <c:forEach begin="1" end="${totalCustomerCount}" step="${pageSize}" varStatus="loop">
                <c:choose>

                    <c:when test="${loop.count > (currentPage-5) && loop.count <= (currentPage+5) || (currentPage <= 5 && loop.count <= 10) || totalPages <=10}">

                        <c:url var="pageLink" value="/part/list">
                            <c:param name="pageNumber" value="${loop.count}" />
                        </c:url>

                        <c:choose>
                            <c:when test="${loop.count == currentPage}">
                                <a href="${pageLink}" class="selected-page">${loop.count}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageLink}">${loop.count}</a>
                            </c:otherwise>
                        </c:choose>

                    </c:when>

                </c:choose>
            </c:forEach>


            <c:choose>
                <c:when test="${currentPage < (totalPages-5) && (totalPages > 10)}">
                    ...
                </c:when>
            </c:choose>


            <c:choose>

                <c:when test="${currentPage == totalPages}">
                    <a href="#" class="disabled">Следующая</a>
                    <a href="#" class="disabled">В конец</a>
                </c:when>

                <c:otherwise>
                    <c:url var="nextPageLink" value="/part/list">
                        <c:param name="pageNumber" value="${currentPage + 1}" />
                    </c:url>
                    <a href="${nextPageLink}">Следующая</a>

                    <c:url var="lastPageLink" value="/part/list">
                        <c:param name="pageNumber" value="${totalPages}" />
                    </c:url>
                    <a href="${lastPageLink}">В конец</a>
                </c:otherwise>

            </c:choose>
        </c:if>

        <div class="text-center">
            <a href="" class="btn btn-info btn-rounded mb-4" data-toggle="modal" data-target="#modaladdpart">Добавить деталь</a>
        </div>
    </div>
    <div class="modal fade" id="modaladdpart" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="padding: 20px;">
                <div class="modal-header text-center">
                    <h2>Добавить деталь</h2>
                    </button>
                </div>
    <form id="newPart" action="/part/addPartToDataBase" method="post">
        <div class="form-group">
        <label>Наименование</label>
                <input id="namePart" name="namePart" class="form-control" type="text" value="">
        </div>
        <div class="form-group">
           <label>Количество</label>
                <input id="quantity" name="quantity" class="form-control" type="number" value="0">
        </div>
        <div class="checkbox">
<label>
                <input id="isBuild1" name="isBuild" type="checkbox" value="1"><input type="hidden" name="_isBuild" value="on"> Используется для сборки</label>
        </div>
        <button type="submit" class="btn btn-default">Добавить</button>
    </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modaleditpart" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="padding: 20px;">
            <div class="modal-header text-center">
                <h2>Редактировать деталь</h2>
                </button>
            </div>
    <form id="editPart" action="/part/addPartToDataBase" method="post">
        <input id="id" name="id" type="hidden" value="211">
        <div class="form-group">
            <label>Наименование</label>
            <input id="namePart" name="namePart" class="form-control" type="text" value="">
        </div>
        <div class="form-group">
            <label>Количество</label>
            <input id="quantity" name="quantity" class="form-control" type="number" value="0">
        </div>
        <div class="checkbox">
            <label>
                <input id="isBuild1" name="isBuild" type="checkbox" value="1"><input type="hidden" name="_isBuild" value="on"> Используется для сборки</label>
        </div>
        <button type="submit" class="btn btn-default">Изменить</button>
    </form>
        </div>
    </div>
    </div>
    <script>
    $(function() {
        $( ".ediforma" ).click(function() {
            $( "#editPart #id" ).val( $(this).attr( "data-id" ));
            $( "#editPart #namePart" ).val( $(this).attr( "data-namtext" ));
            $( "#editPart #quantity" ).val( $(this).attr( "data-quant" ));
            if ($(this).attr( "data-checked" ) == 1)$( "#editPart #isBuild1" ).prop( "checked", true );
            if ($(this).attr( "data-checked" ) == 0)$( "#editPart #isBuild1" ).prop( "checked", false );
        });
    });
</script>
</body>
</html>
