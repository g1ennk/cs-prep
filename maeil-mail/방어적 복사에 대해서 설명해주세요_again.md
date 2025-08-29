# 방어적 복사에 대해서 설명해주세요.

## 1. 정리

### 정의

- 방어적 복사(Defensive Copy)는 원본과의 참조를 끊은 복사본을 만들어 사용하는 방식으로 원본 변경에 의한 부작용을 막는데에 도움이 된다.
- 두 가지 시점
    ```java
    // 1. 생성자의 인자로 받은 객체의 복사본을 만들어 내부 필드를 초기화할 때 
    import java.util.ArrayList;
    import java.util.Collections;
    import java.util.List;
    
    public class Lotto {
    
        private final List<Integer> numbers;
    
        // 생성자에서 방어적 복사
        public Lotto(List<Integer> numbers) {
            // 복사본 먼저 만든 후 검증
            List<Integer> copy = new ArrayList<>(numbers);
            validateSize(copy);
            this.numbers = copy;  // 원본이 아닌 복사본 저장
        }
    
        private void validateSize(List<Integer> numbers) {
            if (numbers.size() != 6) {
                throw new IllegalArgumentException("Lotto must have exactly 6 numbers.");
            }
        }
    }
  
    // 2. getter에서 방어적 복사
    public class Lotto {

    private final List<Integer> numbers;

    public Lotto(List<Integer> numbers) {
        this.numbers = new ArrayList<>(numbers);
    }

    // 방법 1: 복사본 반환
    public List<Integer> getNumbers() {
        return new ArrayList<>(numbers);
    }

    // 방법 2: 수정 불가능한 컬렉션 반환
    public List<Integer> getUnmodifiableNumbers() {
        return Collections.unmodifiableList(numbers);
    }
  }
    ```

## 2. 발화

방어적 복사는 외부에서 전달된 객체나 컬렉션이 내부 상태를 훼손하지 않도록 복사본을 만들어 사용하는 기법입니다.

예를 들어, 생성자에서 생성된 리스트를 그대로 필드에 저장하면, 외부에서 그 리스트를 변경할 때 같은 객체 즉 같은 주소를 바라보기 때문에 내부 값에 대한 변경 가능성이 존재합니다.

이를 해결하기 위해 new 연산자를 활용하여 새로운 객체를 만들어 다른 참조를 바라보게 함으로써 해결할 수 있습니다.

뿐만 아니라, getter에서도 원본 그대로 반환하면 수정 가능성이 존재하기 때문에, 복사본이나 `Collections.unmodifiableList()`를 통해 불변성을 보장할 수 있습니다.

## 3. 추가 자료

- [[10분 테코톡] 이든의 방어적 복사](https://youtu.be/VsYw2GWgZV0?feature=shared)
- [테코블 - 방어적 복사와 Unmodifiable Collection](https://tecoble.techcourse.co.kr/post/2021-04-26-defensive-copy-vs-unmodifiable/)