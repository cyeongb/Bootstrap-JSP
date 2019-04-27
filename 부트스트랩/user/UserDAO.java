package user;


	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;

	public class UserDAO {
		//DAO는 데이터베이스 접근 클래스의 약자로, 
		//실제로 디비에서 회원정보를 불러오고 회원정보를 넣을 떄 사용한다.
		//로그인 기능을 할 수 있는 소스이다.
		
		
		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		public UserDAO() {
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
		
		public int login(String userID , String userPassword) {
			//String sql="select * user Password from user where userID=?";
			String sql="select userPassword from user where userID=?";
				try {
					pstmt =conn.prepareStatement(sql);
					pstmt.setString(1, userID);
					rs=pstmt.executeQuery();
					//쿼리를 실행해서 결과가 실행이 되면 if문을 돌게끔 만든다.
					
					if(rs.next()) {
						// 아이디가 있는 경우, 결과로 나온 유저패스워드를 받아서, 접속시도한 pass와 일치하면
						if(rs.getString(1).equals(userPassword)) {
							return 1; //함수를 강제 종료함으로써 로그인이 성공했다고 알려준다.
						}
						else {
							return 0; //비밀번호 불일치
						}
					}else {
					return -1; //아이디가 없다고 알려준다.
					}
					}catch(Exception e){
					e.printStackTrace();
				}
				return -2; //데이터베이스 오류를 의미.
			}
			//User클래스를 이용해서 user라는 인스턴스를 하나 만든다.
		//join이라는 함수를 하나 만들어서 회원가입의 기능을 하게 해 준다.
			public int join(User user) {
				//각각 물음표에 해당 변수들을 채워 넣는다. 
				String sql="insert into user values(?,?,?,?,?)";
				try {
					pstmt =conn.prepareStatement(sql);
					pstmt.setString(1, user.getUserID());
					pstmt.setString(2, user.getUserPassword());
					pstmt.setString(3, user.getUserName());
					pstmt.setString(4, user.getUserGender());
					pstmt.setString(5, user.getUserEmail());
					//insert 문장을 실행한 경우에는 반드시 0 이상의 숫자가 반환되기 때문에 
					//-1이 아닌 경우에는 성공적으로 회원가입이 되었다는 것을 알 수 있다. 
					return pstmt.executeUpdate();
				}catch(Exception e) {
					e.printStackTrace();
				}
				return -1; //오류가 발생하면 -1을 반환.
				
			}

	}


