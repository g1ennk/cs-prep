# Call By Value와 Call By Reference에 대해서 설명해주세요.

## 1. 정리

### Call By Value
- 메서드를 호출 시 값 자체를 넘겨주는 방식
- 값 자체를 복사하는 방식이기 때문에 원본에 영향이 없음

### Call By Reference
- 메서드 호출 시 참조를 직접 전달하는 방식
- 참조인 주소를 직접 넘기기 때문에 원본 변경 가능성 존재

### 자바
- 자바의 대원칙: `자바는 항상 변수의 값을 복사해서 대입한다.` -> Call By Value
- 원시 타입은 값이 복사되고, 참조 타입은 해당 객쳉의 주소값이 복사된다.

## 2. 발화
메서드를 호출하는 방식은 크게 Call By Value와 Call By Reference가 있습니다.

Call By Value는 말 그대로 값을 복사해서 전달하기 때문에 호출된 메서드에 파라미터를 수정해도 원본에 영향을 주지 않습니다.
반면에 Call By Reference는 참조를 전달하기 때문에 수정 시 원본에 영향을 줍니다.

자바는 이 중 Call By Value만 지원합니다. 원시 타입은 크게 헷갈리지 않지만, 참조의 경우 객체 자체가 넘어가는 것이 아니라
객체의 참조값 즉 주소값이 복사되서 넘어갑니다.
객체 내부 필드를 바꾸면 필드 값이 바뀐거지 원본 객체가 즉 주소값이 변한 것은 아닙니다.
또한 객체 자체를 바꿔도 새로운 객체가 생겨서 대체될 뿐 원본 자체가 바뀌지는 않습니다.

즉, 자바는 항상 값을 복사하며 그 대상이 원시 값이냐 참조값이냐가 다를 뿐입니다.

## 3. 예제 코드
```java
class Student {
    String name;
    Student(String name) { this.name = name; }
}

public class CallByValueDemo {
    public static void main(String[] args) {
        // 1. 원시 타입
        int num = 10;
        changePrimitive(num);
        System.out.println("원시 타입 결과: " + num);
        // 👉 10 (원본 영향 없음)

        // 2. 참조 타입 - 내부 필드 변경
        Student s1 = new Student("Glenn");
        changeField(s1);
        System.out.println("참조 타입(필드 변경) 결과: " + s1.name);
        // 👉 Changed (같은 객체를 바라보므로 내부 필드는 수정됨)

        // 3. 참조 타입 - 참조 자체 변경 (메서드 내부에서만 바뀜)
        Student s2 = new Student("Glenn");
        changeReference(s2);
        System.out.println("참조 타입(참조 교체) 결과: " + s2.name);
        // 👉 Glenn (원본 영향 없음)

        // 4. 객체 자체를 교체 (리턴받아 다시 대입해야 반영됨)
        Student s3 = new Student("Glenn");
        s3 = replaceReference(s3); // 새로운 객체를 반환받아 대입
        System.out.println("객체 자체 교체 결과: " + s3.name);
        // 👉 New Student (원본까지 바뀜)
    }

    static void changePrimitive(int value) {
        value = 20; // 복사본만 바뀜
    }

    static void changeField(Student s) {
        s.name = "Changed"; // 같은 객체를 바라보기 때문에 원본에도 반영됨
    }

    static void changeReference(Student s) {
        s = new Student("New Student");
        // 복사된 참조만 교체됨 → 원본 변수는 그대로
    }

    static Student replaceReference(Student s) {
        return new Student("New Student");
        // 새로운 객체를 리턴 → 호출한 쪽에서 다시 대입해야 원본이 바뀜
    }
}
```