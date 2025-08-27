package com.bincui.colab.global.common.response.core;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;

import java.time.LocalDateTime;

/**
 * API 응답 종류와 관계 없이 응답 본문에 포함될 공통 필드들을 정의한 클래스
 */

@Getter
public class BaseResponse {

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
    private final LocalDateTime responseAt;

    private final int code;

    private final String message;

    public BaseResponse(int code, String message) {
        this.responseAt = LocalDateTime.now();
        this.code = code;
        this.message = message;
    }
}
