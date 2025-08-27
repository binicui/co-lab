package com.bincui.colab.global.common.response.base;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

/**
 * 응답 본문 구성시 사용될 HTTP 상태코드, 응답 코드, 메시지 등을 정의 및 관리하기 위한 열거형
 */

@RequiredArgsConstructor
@Getter
public enum ResponseType {

    OK (100000, "요청이 정상적으로 처리되었습니다.", HttpStatus.OK),

    INVALID_PARAMETER_VALUE (-800101, "요청 파라미터의 값이 유효하지 않습니다.", HttpStatus.BAD_REQUEST),
    INVALID_PARAMETER_TYPE (-800102, "유효하지 않은 타입의 요청 파라미터입니다.", HttpStatus.BAD_REQUEST),
    UNSUPPORTED_HTTP_METHOD (-805100, "지원하지 않는 HTTP 메소드 요청입니다.", HttpStatus.METHOD_NOT_ALLOWED),
    INTERNAL_SERVER_ERROR (-999999, "내부 서버에 에러가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR)
    ;

    private final int code;
    private final String message;
    private final HttpStatus status;
}