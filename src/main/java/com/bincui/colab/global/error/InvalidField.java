package com.bincui.colab.global.error;

import com.bincui.colab.global.utils.ExceptionUtils;
import jakarta.validation.ConstraintViolation;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 잘못된 사용자의 요청 파라미터로 인해 발생된 에러 정보를 반환하는 클래스
 */

@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Getter
public class InvalidField {

    private final String field;
    private final String value;
    private final String reason;

    /**
     * 특정 필드에 의해 발생된 에러 정보를 리스트로 반환한다.
     *
     * @param field     에러가 발생된 필드명
     * @param value     입력값
     * @param reason    에러가 발생된 원인
     * @return          {@link InvalidField} 리스트
     */
    public static List<InvalidField> of(String field, String value, String reason) {
        List<InvalidField> errors = new ArrayList<>();
        errors.add(new InvalidField(field, value, reason));
        return errors;
    }

    /**
     * {@link BindingResult}의 필드 에러 정보를 리스트로 반환한다.
     *
     * @param   bindingResult 검증 에러 객체
     * @return  {@link InvalidField} 리스트
     */
    public static List<InvalidField> of(BindingResult bindingResult) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        return errors.stream().map(error -> new InvalidField(
                error.getField(),
                ExceptionUtils.nullSafeToString(error.getRejectedValue()),
                error.getDefaultMessage()
        )).collect(Collectors.toList());
    }

    /**
     * 제약조건 위반으로 인해 발생된 에러 정보를 리스트로 반환한다
     *
     * @param violations    제약조건 위반 정보를 담고 있는 객체
     * @return              {@link InvalidField} 리스트
     */
    public static List<InvalidField> of(Set<ConstraintViolation<?>> violations) {
        List<ConstraintViolation<?>> errors = new ArrayList<>(violations);
        return errors.stream().map(error -> new InvalidField(
                ExceptionUtils.violationField(error.getPropertyPath().toString()),
                ExceptionUtils.nullSafeToString(error.getInvalidValue()),
                error.getMessage()
        )).collect(Collectors.toList());
    }

    public static List<InvalidField> of(MethodArgumentTypeMismatchException e) {
        String field = e.getName();
        String reason = field + " 값의 타입은 " + Objects.requireNonNull(e.getRequiredType()).getSimpleName() + "이어야 합니다.";
        return of(field, ExceptionUtils.nullSafeToString(e.getValue()), reason);
    }
}
