package com.bincui.colab.global.utils;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;

/**
 * 프로젝트 내에서 사용되는 사용 여부 또는 삭제 여부 등의 상태값들을 코드단에서 효율적으로 처리하기 위해
 * 서로 다른 타입의 값들을 의미별로 정의한 열거형.
 *
 * @author SUBIN PARK
 */

@RequiredArgsConstructor
@Getter
public enum StatusValues {

    YES (1, "Y", true),
    NO (0, "N", false)
    ;

    private final int numeric;

    private final String character;

    private final boolean bool;

    /**
     * 주어진 정수형 인자의 일치여부에 따라 알맞은(같은 의미를 지닌) 논리형 상태값을 반환한다.
     *
     * @param status    논리형 상태값으로 변환하고자 하는 정수형 인자
     * @return          전달된 인자값이 {@code 1}일 경우 {@code true}를, {@code 0}일 경우 {@code false}를 반환
     */
    public static boolean valueOf(int status) {
        return Arrays.stream(values())
                .filter(e -> e.getNumeric() == status)
                .findFirst()
                .map(StatusValues::isBool)
                .orElseThrow(() -> new IllegalArgumentException("Cannot convert '" + status + "' to boolean type!"));
    }
}
