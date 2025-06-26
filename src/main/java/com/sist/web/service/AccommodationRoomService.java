package com.sist.web.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.web.dao.AccommodationRoomDao;
import com.sist.web.model.AccommodationRoom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
@Service
public class AccommodationRoomService {

    @Autowired
    private AccommodationRoomDao accommodationRoomDao;

    /**
     * DB에 저장된 모든 숙소 ID 목록 조회
     * 변수명: accommId (accomm 줄임말 사용 일관)
     */
    public List<String> getAllAccommIds() {
        return accommodationRoomDao.getAllAccommIds();
    }

    /**
     * API에서 숙소 ID를 통해 객실 정보 가져오기 (기존 API 호출 유지)
     */
    private static final String ROOM_BASE_URL = "http://apis.data.go.kr/B551011/KorService2/detailInfo2";
    private static final String SERVICE_KEY =
        "MHbE44hd7kHCOFVk5VucNc1XiPWTzxPAraI2RBlclEk8DFoZtBZWPX1gTMSVJ5j1U6ggq3bD6eViUAyxJfBpdQ==";

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();



    /**
     * 숙소 ID(accommId)로 객실 정보 가져오기
     */
    public List<AccommodationRoom> fetchAccommodationRoom(String accommId) throws Exception {
        // 서비스키 인코딩
        String encodedKey = URLEncoder.encode(SERVICE_KEY, StandardCharsets.UTF_8.name());
        // 쿼리 조립
        String rawQuery = "serviceKey=" + encodedKey +
                          "&contentId="  + accommId +
                          "&_type=json";
        String fullUrl = ROOM_BASE_URL + "?" + rawQuery;
        URI uri = URI.create(fullUrl);

        // 호출
        String response = restTemplate.getForObject(uri, String.class);
        if (response == null || response.trim().isEmpty()) {
            return new ArrayList<>();
        }
        if (response.trim().startsWith("<")) {
            throw new RuntimeException("객실 API 호출 실패: " + response);
        }

        // JSON 파싱: response.body.items.item 배열
        JsonNode itemsNode = objectMapper.readTree(response)
            .path("response")
            .path("body")
            .path("items")
            .path("item");

        List<AccommodationRoom> rooms = new ArrayList<>();
        if (itemsNode.isArray()) {
            for (JsonNode node : itemsNode) {
                AccommodationRoom room = objectMapper.treeToValue(node, AccommodationRoom.class);
                rooms.add(room);
            }
        }
        return rooms;
    }

    /**
     * 객실 존재 여부 확인 (중복 체크)
     * 파라미터명도 일관되게 accommRoomId로 맞춤
     */
    public boolean existsAccommodationRoom(String accommRoomId) {
        int count = accommodationRoomDao.existsAccommodationRoom(accommRoomId);
        return count > 0;
    }

    /**
     * 객실 정보 단건 저장
     */
    public void saveAccommodationRoom(AccommodationRoom room) {
        accommodationRoomDao.insertAccommodationRoom(room);
    }

    /**
     * 객실 ID 생성 (시퀀스 nextval 활용)
     */
    public String generateAccommRoomId() {
        Long nextVal = accommodationRoomDao.getNextAccommRoomSeq();
        return "R_" + nextVal;
    }

    /**
     * 객실 목록 저장 (중복 체크 포함, 트랜잭션 처리)
     */
    @Transactional
    public void saveAccommodationRoomList(List<AccommodationRoom> roomList) {
        if (roomList == null || roomList.isEmpty()) {
            return;
        }

        for (AccommodationRoom room : roomList) {
            if (room == null) {
                continue;  // null 방어
            }

            // 객실 ID가 없으면 새로 생성 후 설정
            if (room.getAccommRoomId() == null || room.getAccommRoomId().isEmpty()) {
                String newId = generateAccommRoomId();
                room.setAccommRoomId(newId);
            }

            // DB에 없는 경우에만 저장
            if (!existsAccommodationRoom(room.getAccommRoomId())) {
                saveAccommodationRoom(room);
            }
        }
    }

}
