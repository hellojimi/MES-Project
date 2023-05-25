# MES(주) 주사기제조공장의 생산관리시스템(MES)

<img src="BESimages/MES_main.PNG" width="95%" height="90%"></img>

### 호스팅 사이트 : http://itwillbs19.cafe24.com/login/login
#### 개발 도구 : STS, Workbench
#### 사용언어 : Java(OpenJDK 11.0.2), MySQL(8.0.17), JavaScript
#### 라이브러리 : jQuery(3.6.4), JSTL(1.2)
#### 프레임워크 : Spring(4.3.8.RELEASE), MyBatis
#### 웹어플리케이션 도구 : JSP MVC Model2
#### 주제 : Spring 기반 MES시스템 설계

---

#### 프로젝트 기간 : 3월 8일 ~ 4월 14일
#### 담당 기능 : 작업지시 정보관리 페이지, 작업지시 현황 페이지, 라인 페이지

### 🛠개발 코드💻

#### 작업지시 정보관리, 작업지시현황 페이지
* Model
  - 작업지시 DAO [InstructDAO.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/work/dao/InstructDAO.java)
  - 작업지시 DAOImpl [InstructDAOImpl.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/work/dao/InstructDAOImpl.java)
  - 작업지시 Service [InstructService.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/work/service/InstructService.java)
  - 작업지시 ServiceImpl [InstructServiceImpl.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/work/service/InstructServiceImpl.java)
  - 작업지시 Mapper [instructMapper.xml](https://github.com/hellojimi/MES-Project/blob/develop/src/main/resources/mappers/instructMapper.xml)
  - 작업지시 DTO [InstructDTO.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/work/domain/InstructDTO.java)

* View
  - 작업지시 리스트 [instructList.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/work/instructList.jsp)
  - 작업지시 등록 팝업 [instructInsert.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/work/instructInsert.jsp)
  - 작업지시 수정 팝업 [instructModify.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/work/instructModify.jsp)
  - 작업지시 라인 리스트 [lineList.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/work/lineList.jsp)
  - 작업지시 수주 리스트 [orderList.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/work/orderList.jsp)
  - 작업지시현황 리스트 [instructState.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/work/instructState.jsp)

* Controller
  - 컨트롤러 [InstructController.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/work/controller/InstructController.java)
  - 컨트롤러(ajax) [InstructAjaxController.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/work/controller/InstructAjaxController.java)
  - 작업지시현황 컨트롤러 [InstructController.java (L80-L129)](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/work/controller/InstructController.java#L80-L129)

#### 라인 페이지
* Model
  - 라인 DAO [LineDAO.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/line/dao/LineDAO.java)
  - 라인 DAOImpl [LineDAOImpl.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/line/dao/LineDAOImpl.java)
  - 라인 Service [LineService.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/line/service/LineService.java)
  - 라인 ServiceImpl [LineServiceImpl.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/line/service/LineServiceImpl.java)
  - 라인 Mapper [lineMapper.xml](https://github.com/hellojimi/MES-Project/blob/develop/src/main/resources/mappers/lineMapper.xml)
  - 라인 DTO [LineDTO.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/line/domain/LineDTO.java)

* View
  - 라인 리스트 [line.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/line/line.jsp)
  - 라인 등록 [lineInsert.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/line/lineInsert.jsp)
  - 라인 수정 [lineModify.jsp](https://github.com/hellojimi/MES-Project/blob/develop/src/main/webapp/WEB-INF/views/line/lineModify.jsp)

* Controller
  - 컨트롤러 [LineController.java](https://github.com/hellojimi/MES-Project/blob/develop/src/main/java/com/itwillbs/line/controller/LineController.java)
