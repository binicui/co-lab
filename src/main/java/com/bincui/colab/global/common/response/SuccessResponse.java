package com.bincui.colab.global.common.response;

import com.bincui.colab.global.common.response.base.ApiResponse;
import com.bincui.colab.global.common.response.base.ResponseType;
import lombok.Getter;

/**
 * 성공 응답 클래스
 */

@Getter
public class SuccessResponse<T> extends ApiResponse {

    private final T data;

    private SuccessResponse(int code, String message, T data) {
        super(code, message);
        this.data = data;
    }

    /**
     * 성공 응답을 반환한다.
     * 
     * @param data  응답 결과 데이터
     * @return      {@link SuccessResponse} 객체
     * @param <T>   응답 결과 데이터의 타입
     */
    public static<T> SuccessResponse<T> of(T data) {
        return new SuccessResponse<>(ResponseType.OK.getCode(), ResponseType.OK.getMessage(), data);
    }
}