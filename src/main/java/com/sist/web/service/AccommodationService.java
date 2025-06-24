package com.sist.web.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.web.dao.AccommodationDao;
import com.sist.web.model.Accommodation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Service
public class AccommodationService {
    private static final String BASE_URL = "http://apis.data.go.kr/B551011/KorService2/searchStay2";
    private static final String SERVICE_KEY =
            "MHbE44hd7kHCOFVk5VucNc1XiPWTzxPAraI2RBlclEk8DFoZtBZWPX1gTMSVJ5j1U6ggq3bD6eViUAyxJfBpdQ==";

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private AccommodationDao accommodationDao;

    public List<Accommodation> fetchAccommodation(int pageNo, int numOfRows, String sigunguCode) throws Exception {
        // 서비스키 직접 인코딩
        String encodedKey = URLEncoder.encode(SERVICE_KEY, StandardCharsets.UTF_8.name());

        // 쿼리 파라미터 직접 조립
        String rawQuery = "serviceKey=" + encodedKey +
                          "&MobileOS=ETC" +
                          "&MobileApp=MyApp" +
                          "&_type=json" +
                          "&sigunguCode=" + sigunguCode +
                          "&pageNo=" + pageNo +
                          "&numOfRows=" + numOfRows;

        String fullUrl = BASE_URL + "?" + rawQuery;
        URI uri = URI.create(fullUrl);

        System.out.println("요청 URL = " + fullUrl);

        String response = restTemplate.getForObject(uri, String.class);

        if (response != null && response.trim().startsWith("<")) {
            throw new RuntimeException("API 호출 실패: " + response);
        }

        JsonNode itemsNode = objectMapper.readTree(response)
                .path("response")
                .path("body")
                .path("items")
                .path("item");

        List<Accommodation> resultList = new ArrayList<>();
        if (itemsNode.isArray()) {
            for (JsonNode node : itemsNode) {
                Accommodation accom = objectMapper.treeToValue(node, Accommodation.class);
                accom.setSellerId("admin");
                accom.setAccomStatus("Y");
                accom.setAccomAvg(0);
                resultList.add(accom);
            }
        }
        return resultList;
    }

    public void saveAccommodationList(List<Accommodation> list) {
        for (Accommodation accom : list) {
            accommodationDao.insertAccommodation(accom);
        }
    }
}
