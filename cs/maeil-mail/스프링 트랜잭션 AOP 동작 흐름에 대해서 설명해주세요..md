# 스프링 트랜잭션 AOP 동작 흐름에 대해서 설명해주세요.

## 요약

### 1. 핵심 개념

- 스프링 트랜잭션 기능은 AOP(관점 지향 프로그래밍) 기반으로 동작한다.
- 즉, `@Transactional`이 붙은 메서드는 실제 비즈니스 로직을 실행하기 전에 `프록시`가 가로채어 트랜잭션 경계를 설정한다.
- 내부적으로는 `PlatformTransactionalManager`가 트랜잭션의 시작, 커밋, 롤백을 관리한다.

### 2. 주요 등장 요소

1. Transaction Manager: PlatformTransactionManager 인터페이스
    - `DataSourceTransactionManager`, `JpaTransactionalManager`가 대표적인 구현체
2. Transaction AOP Proxy (Proxy + TransactionInterceptor)
    - `@Transaction` 메서드 호출을 가로채 트랜잭션을 관리
3. TransactionSynchronizationManager
    - ThreadLocal에 커넥션을 저장해 같은 트랜잭션을 공유할 수 있게 함.

### 3. 동작 흐름

1. 프록시 생성
    - 스프링이 `@Transactional`이 붙은 빈을 스캔하면서 해당 빈을 프록시 객체로 감싼다.
2. 메서드 호출 가로채기
    - 클라이언트가 해당 어노테이션이 붙은 메서드를 호출하면 실제 객체가 아닌 프록시 객체가 먼저 호출된다.
3. 트랜잭션 어드바이스 실행
    - 프록시 객체가 `TransactionInterceptor`라는 AOP 어드바이스를 실행한다.
    - 이때 트랜잭션 속성(전파, 격리수준, readOnly 등)을 확인
4. 트랜잭션 시작
    - `PlatformTransactionalManager`를 통해 `begin` 실행
    - DB 커넥션을 가져오고, 오토 커밋을 끄고, 트랜잭션 컨텍스트를 ThreadLocal에 저장
5. 실제 메서드 실행
    - 비즈니스 로직 수행
6. 정상 종료 vs 예외 발생
    - 정상 종료 시 TransactionManager.commit()을 호출하여 DB에 반영한다.
    - 예외 처리: `RuntimeException`이나 `Error` 후 롤백
7. 트랜잭션 정리
    - Connection 반납하고 ThreadLocal 정리

## 발화

스프링의 트랜잭션은 AOP 기반 프록시로 동작합니다.
해당 어노테이션이 붙은 메서드를 호출하면 프록시 객체가 가로채어 트랜잭션 어드바이스인 `TransactionInterceptor`가 실행됩니다.
이때 TransactionalManager를 통해 DB 커넥션을 가져오고 본격적으로 트랜잭션을 실행합니다.
이후 비즈니스 로직을 수행하고 결과에 따라 정상 종료되어 커밋되거나, 예외가 발생하여 롤백이 일어나기도 합니다.
이로 인해 개발자는 복잡한 커넥션 관리나 트랜잭션 코드 없이 어노테이션만으로 안전하게 트랜잭션을 관리할 수 있습니다.

## 추가 학습 자료

- https://www.maeil-mail.kr/question/181
