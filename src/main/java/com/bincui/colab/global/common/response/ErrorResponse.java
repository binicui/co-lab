package com.bincui.colab.global.common.response;

import com.bincui.colab.global.common.response.core.BaseResponse;
import com.bincui.colab.global.common.response.core.ResponseType;
import com.bincui.colab.global.error.InvalidField;
import lombok.Builder;
import lombok.Getter;

import java.util.Collections;
import java.util.List;

/**
 * 실패 및 에러 응답 클래스
 */

@Getter
public class ErrorResponse extends BaseResponse {

    private final List<InvalidField> errors;

    @Builder
    private ErrorResponse(int code, String message, List<InvalidField> errors) {
        super(code, message);
        this.errors = errors;
    }

    /**
     * 실패 응답을 반환한다.
     * 
     * @param responseType  에러 응답 코드 및 메시지 등이 정의된 열거형
     * @param errors        상세 에러 정보 리스트
     * @return              {@link ErrorResponse} 객체
     */
    public static ErrorResponse failure(ResponseType responseType, List<InvalidField> errors) {
        return ErrorResponse.builder()
                .code(responseType.getCode())
                .message(responseType.getMessage())
                .errors(errors == null ? Collections.emptyList() : errors)
                .build();
    }

    /**
     * 에러 응답을 반환한다.
     * 
     * @param responseType  에러 응답 코드 및 메시지 등이 정의된 열거형
     * @return              {@link ErrorResponse} 객체
     */
    public static ErrorResponse error(ResponseType responseType) {
        return ErrorResponse.builder()
                .code(responseType.getCode())
                .message(responseType.getMessage())
                .build();
    }
}
