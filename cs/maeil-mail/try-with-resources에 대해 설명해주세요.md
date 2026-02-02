# try-with-resources에 대해 설명해주세요

## 요약

- 커넥션, 입출력 스트림과 같은 자원을 사용한 후에는 자원을 해제해야 성능 문제나 메모리 누수 등을 방지할 수 있다.
- 원래라면 각 리소스마다 close를 호출해서 해제해야하지만, java 7부터 try-with-resources가 도입되어 자동으로 자원을 해제할 수 있다.
- 해당 기능을 사용하는 방법은 다음과 같다.
    - `AutoCloseable` 인터페이스 구현 객체를 사용하고
    - `try()` 괄호 내에 변수를 선언해야 한다.

```java
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

// INSERT 예시

public void save(DataSource ds, long userId) throws SQLException {

    String sql = "INSERT INTO users(id) VALUES (?)";

    try (Connection conn = ds.getConnection()) {
        conn.setAutoCommit(false);
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.executeUpdate();
            conn.commit();
        } catch (Exception e) {
            conn.rollback();
            throw e;
        }
    } // ps -> conn 순서로 자동 close

}
```

### finally 대신에 try-with-resources를 사용해야 하는 이유는?

- 앞서 말했든 finally를 사용하면 close를 명시적으로 호출해야하지만, 이 경우 호출이 누락되거나 예외가 터지면 복잡한 문제가 발생한다.
- 또한 여러 개의 리소스를 해제하는 도중 중간에 한 리소스가 예외가 터지면 그 이후에 리소스는 해제되지 않는다.
- 따라서 이러한 finally가 가진 문제를 해결하기 위해 try-with-resources는 다음과 같은 문제를 해결한다.
    - try 블록 종료 시 close를 자동으로 호출해서 자원을 해제한다.
    - finally 블록 없이도 자원을 안전하게 정리하기 때문에 코드가 간결해진다.
    - try 문에서 여러 자원 선언 시, 선언된 반대 순서로 자동 해제된다.

### Suppressed Exception(억제된 예외)란 무엇인가요?

- Suppressed Exception은 예외가 발생했지만 무시되는 예외를 의미한다.
- try-with-resources에서 close 과정에서 발생된 예외는 Suppressed Exception에서 관리한다.
- 해당 예외가 필요한 이유는 원래 예외를 유지하면서 추가 예외도 추적할 수 있고, 자원을 안전하게 해제하면서 예외를 효율적으로 처리할 수 있다.

## 발화

try-with-resources는 사용 후 해제해야하는 자원을 try() 괄호 안에 호출하면, 블록이 끝날 때 자동으로 close 해주는 문법이다.\
여기서 자원은 `AutoCloseable`을 구현한 리소스여야 합니다.

try-catch-finally와 비교해서 장점은 다음과 같습니다.\
먼저, finally 블록 없이 자동으로 해제해주고,\
자원이 여러 개여도 역순으로 안전하게 닫히고,\
코드가 짧아 가독성이 올라가고,\
닫는 중간 생긴 예외는 Suppressed Exception으로 넘어가 주원인 예외를 보존하면서 추가로 추적이 가능합니다.

따라서 try-with-resources를 적극적으로 사용하면 위와 같은 이점을 받을 수 있습니다.\
핵심은 세 가지입니다.

1. `AutoClosable` 자원을 `try()`에 올린다.
2. 블록 종료 시 역순으로 자동 해제된다.
3. `close()` 중 생긴 예외는 suppressed로 남긴다.
