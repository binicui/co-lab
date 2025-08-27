package com.bincui.colab.global.common.response;

import com.bincui.colab.global.common.response.core.BaseResponse;
import com.bincui.colab.global.common.response.core.ResponseType;
import lombok.Getter;

/**
 * 성공 응답 클래스
 */

@Getter
public class ApiResponse<T> extends BaseResponse {

    private final T data;

    private ApiResponse(int code, String message, T data) {
        super(code, message);
        this.data = data;
    }

    /**
     * 성공 응답을 반환한다.
     * 
     * @param data  응답 결과 데이터
     * @return      {@link ApiResponse} 객체
     * @param <T>   응답 결과 데이터의 타입
     */
    public static<T> ApiResponse<T> ok(T data) {
        return new ApiResponse<>(ResponseType.OK.getCode(), ResponseType.OK.getMessage(), data);
    }
}
