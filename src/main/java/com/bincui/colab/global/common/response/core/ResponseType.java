package com.bincui.colab.global.common.response.core;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

/**
 * API 응답의 본문 구성시 사용될 응답 코드를 포함한 정보들을 정의 및 관리하기 위한 열거형
 */

@RequiredArgsConstructor
@Getter
public enum ResponseType {

    /**
     * 공통 성공 응답 코드
     */
    OK (HttpStatus.OK, 100000, "요청이 정상적으로 처리되었습니다."),

    /**
     * 공통 에러 응답 코드
     */
    INVALID_PARAMETER_VALUE (HttpStatus.BAD_REQUEST, -800101, "요청 파라미터의 값이 유효하지 않습니다."),
    INVALID_PARAMETER_TYPE (HttpStatus.BAD_REQUEST, -800102, "유효하지 않은 타입이 요청 파라미터입니다."),
    UNSUPPORTED_METHOD (HttpStatus.METHOD_NOT_ALLOWED, -805100, "지원하지 않는 HTTP 메소드 요청입니다."),
    INTERNAL_SERVER_ERROR (HttpStatus.INTERNAL_SERVER_ERROR, -999999, "내부 서버에 에러가 발생했습니다.")
    ;

    private final HttpStatus status;

    private final int code;

    private final String message;
}
