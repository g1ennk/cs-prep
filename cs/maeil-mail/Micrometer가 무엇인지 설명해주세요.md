# Micrometer가 무엇인지 설명해주세요

## 요약

### Micrometer란 무엇이며, 왜 사용하나요?

- Micrometer는 벤더 중립적인 메트릭 계측 라이브러리로, 애플리케이션에서 발생하는 다양한 지표를 수집합니다.
  - ex) CPU 사용량, 메모리 소비, HTTP  요청 및 커스텀 이벤트
- 해당 라이브러리를 통해 Prometheus, Datadog 등 여러 모니터링 시스템에 메트릭 정보를 전송할 수 있도록 일관된 API를 제공한다.
- 따라서 각 백엔드 클라이언트의 복잡한 세부 구현을 감춥니다.
- 특히 Spring Boot Actuator와 깊이 통합되어, 기본 메토릭을 자동으로 수집하고 노출할 수 있다.

### Spring Boot Actuator와 Micrometer의 관계는 무엇인거요?

- Actuator는 애플리케이션의 상태, 헬스 체크, 환경, 로그 등 여러 운영 정보를 노출하는 관라 엔드 포인트를 제공한다.
- 즉, Actuator가 내부적으로 Micrometer를 사용하여 JVM, HTTP, 데이터베이스 등 다양한 메트릭을 수집한다.
- 즉, Actuator가 모니터링 및 관리 인터페이스를 제공하고, Micrometer가 그 밑에 실제 메트릭 데이터를 계측하고 전송하는 역할을 한다.

### Micrometer를 사용하여 커스텀 메트릭을 생성하는 방법을 설명해주세요.

1. MeterRegistry 사용: 생성자에서 MeterRegistry를 주입 받아 애플리케이션의 모든 메트릭을 중앙에서 관리하고, 설정된 모니터링 백엔드로 주기적 전송
2. Counter: 매 HTTP 요청마다 요청 건수를 카운트한다.
3. Timer: HTTP 요청 처리 시간을 측정한다.
4. Gauge: 현재 활성 세션 수를 측정한다.

## 발화

MicroMeter는 메트릭 계측 라이브러리로, 애플리케이션에서 발생하는다양한 자료를 수집하여 모니터링 툴에 관련 데이터를 전송할 수 있도록합니다.

특히 Spring Boot의 Actuator와 깊이 통합되어 Actuator를 통해 애플리케이션의 상태, 헬스 체크, 환경 등의 정보의 관한 API 엔드 포인트를 제공합니다.

즉, Actuator가 모니터링 및 관리 인터페이스를 제공하고, Micrometer가 그 밑에 실제 메트릭 데이터를 계측하고 전송하는 역할을 합니다.

특히 Micrometer로 커스팀 메트릭을 생성하는 방법이 있습니다.

먼저 생성자로 MeterRegistry를 주입 받아 애플리케이션의 모든 메트릭을 관리합니다.

이후 요청 건수를 카운트하는 Counter, HTTP 요청 처리 시간을 측정하는 Timer, 활성 세션 수를 측정하는 Gauge 등을 사용할 수 있습니다.