<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../../jspf/header.jspf"%>

<link type="text/css" media="screen" rel="stylesheet" href="${s}/css/calendar.css" />

<div style="max-width: 60%; margin: 0 auto;">
   <h1>Calendario de eventos</h1>
</div>

<div style="max-width: 50%; margin: 0 auto;">
  <div class="month"> 
    <ul>
      <li class="prev">&#10094;</li>
      <li class="next">&#10095;</li>
      <li>Enero<br><span style="font-size:18px">2019</span></li>
    </ul>
  </div>

  <ul class="weekdays">
    <li>Lunes</li>
    <li>Martes</li>
    <li>Miércoles</li>
    <li>Jueves</li>
    <li>Viernes</li>
    <li>Sábado</li>
    <li>Domingo</li>
  </ul>

  <ul class="days"> 
    <li>1</li>
    <li>2</li>
    <li>3</li>
    <li>4</li>
    <li>5</li>
    <li>6</li>
    <li>7</li>
    <li>8</li>
    <li>9</li>
    <li><span class="active">10</span></li>
    <li>11</li>
    <li>12</li>
    <li>13</li>
    <li>14</li>
    <li>15</li>
    <li>16</li>
    <li>17</li>
    <li>18</li>
    <li>19</li>
    <li>20</li>
    <li>21</li>
    <li>22</li>
    <li>23</li>
    <li>24</li>
    <li>25</li>
    <li>26</li>
    <li>27</li>
    <li>28</li>
    <li>29</li>
    <li>30</li>
    <li>31</li>
  </ul>
</div>
</div>

<div style="max-width: 50%; margin: 0 auto;">
   <h2>Eventos para el miércoles 10:</h2>
   <li>Partido de rugby Matemáticas - Física. 17:00h </li>
</div>
<div style="height: 50px;"></div>


<%@ include file="../../jspf/footer.jspf"%>
