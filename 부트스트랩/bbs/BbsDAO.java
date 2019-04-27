package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import java.sql.PreparedStatement; -->각각 함수끼리 디비에서의 마찰이 있을 수 있기 떄문에 메서드 안에서 선언해 준다
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO { //Data Access Object


	private Connection conn;
	
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			//실재 mysql에 접속을 하게 해 주는 부분.
			//3306은 우리 컴퓨터에 생성된 서버 포트 번호이고, 거기서 bbs라는 디비에 접속 할 수 있도록 해 준다.
			String dbUrl="jdbc:mysql://localhost:3306/bbs"; 
			String dbID="root";
			String dbPassword="chldud0102";	
			Class.forName("com.mysql.jdbc.Driver"); //드라이버는 mysql에 접속 할 수 있도록하는 하나의 라이브러리.
			conn=DriverManager.getConnection(dbUrl, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();  //오류를 추적해서, 오류가 뭔지 알 수 있도록 해 준다
		}
	}
	
	// 게시판 글쓰기를 하려면 총 3개의 함수가 필요하다. 
	//****** 1.현재 시간을 String형으로 가져오는 메서드 *********
	public String getDate() {  //현재 서버의 시간을 가져오는 메서드
		String sql="select now()";  //현재의 시간을 호출하는 sql문.		
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);  //sql문을 실행 준비단계로 레디 시킨다.
			rs=pstmt.executeQuery(); //실재로 실행했을 때 나오는 결과를 rs에 담아서 가져온다.
			if(rs.next()) {
				return rs.getString(1);  //현재의 날짜를 그대로 반환해 준다.
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return " ";  //데이터베이스 오류가 나면 빈 문자열 리턴
	}
	
	//****** 2. 조회수 control하는 메서드 *********
	public int getNext() {
		//sql문 --> 내림차순으로 정렬해서 가장 마지막에 쓰인 글을 가져와서
		// 그 글에 1을 더한 값이  다음 글의 번호가 되게한다.
		String sql="select bbsID from BBS order by bbsID desc"; 
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;   //마지막에 쓰인 글의 번호+1을 더해서  그 다음 게시글의 번호가 들어가게 만든다.
			}else {
				return 1;   //앞의 게시물이 없는 경우 첫번째 게시물 임을 알려준다.
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;  //게시글에 적합하지 않은 -1을 반환함으로써 디비오류임을 감지하게 한다.
	}
	
	//****** 3. 글 쓰기 control하는 메서드 *********
	public int wirte(String bbsTitle,String userID,String bbsContent) {
		String sql="insert into BBS values(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,getNext());  //1.게시글 번호
			pstmt.setString(2,bbsTitle);
			pstmt.setString(3,userID);
			pstmt.setString(4,getDate());
			pstmt.setString(5,bbsContent);
			pstmt.setInt(6,1);  //available구역. db에입력했듯이.. 1을 줘서 글이 존재한다는 것을 알려준다.
			
			return pstmt.executeUpdate(); //성공적으로 수행하면 0 이상의 수를 반환한다.
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//*********** 4. db에서 글의 목록을 가져오는 소스코드. **************
	//=======4_1 : 1~10까지 글 목록을 제한해서 불러온다,
	// 배열로 된 리스트를 외부 라이브러리에서 가져올 수 있도록 한다.
		public ArrayList<Bbs>getList(int pageNumber){
			//삭제가 되지 않아서 avail이 1인 글을 가져온다. + 내림차순해서 10까지만 가져온다.
			String sql="select * from BBS where bbsID<? and bbsAvailable=1 order by bbsID desc limit 10";
			ArrayList<Bbs> list=new ArrayList<Bbs>();
			try {
				PreparedStatement pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1,getNext()-(pageNumber-1)*10);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					Bbs bbs=new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setDatetime(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					list.add(bbs);
				}
				
			}catch(Exception e){
				e.printStackTrace();
				System.out.println("오류발생:"+e);				
			}

			return list;
		}
	
		//4_2 ********* 그 다음 페이지로 이동하기(페이징 처리) *******
		public boolean nextPage(int pageNumber) {
			String sql="select * from BBS where bbsID<? and bbsAvailable=1";
			try {
				PreparedStatement pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1,getNext()-(pageNumber-1)*10);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					return true;
				}			
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println(e);
			}
			return false;
		}
		//-----------5. 게시글 가져오기(view.jsp)
		public Bbs getBbs(int bbsID) {
			String sql="select * from BBS where bbsID=?";
			try {
				PreparedStatement pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, bbsID);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					Bbs bbs=new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setDatetime(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					return bbs;
				}
				
				
			}catch(Exception e) {
					e.printStackTrace();
					System.out.println(e);
				}
			return null;  //글이 존재하지 않을 때.
			}
		
		//-------------- 6. 글 수정하기 -------------------------------------
		public int update(int bbsID,String bbsTitle ,String bbsContent) {
			String sql="update BBS set bbsTitle=?, bbsContent=?  where bbsID=?";
			try {
				PreparedStatement pstmt=conn.prepareStatement(sql);			
				pstmt.setString(1,bbsTitle);
				pstmt.setString(2,bbsContent);
				pstmt.setInt(3,bbsID);
				return pstmt.executeUpdate();			
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		//----------- 7.글 삭제하기 ------------------------------------
		public int delete(int bbsID) {
			//글을 삭제하더라도 글에대한 정보가 남아있도록 어베일을 0으로 만든다.
			//이걸로 delete함수를 구현할 수 있다.
			String sql="update BBS set bbsAvailable=0 where bbsID=?";
			try {
				PreparedStatement pstmt=conn.prepareStatement(sql);			
				pstmt.setInt(1,bbsID);
				return pstmt.executeUpdate();			
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
}
