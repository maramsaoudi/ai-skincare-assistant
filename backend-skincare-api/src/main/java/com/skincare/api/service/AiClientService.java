package com.skincare.api.service;

import com.skincare.api.dto.AiScanResponse;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@Service
public class AiClientService {

    private final RestTemplate restTemplate = new RestTemplate();

    public AiScanResponse analyzeSkin(MultipartFile image) {
        try {
            String aiUrl = "http://127.0.0.1:8000/analyze";

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            ByteArrayResource imageResource = new ByteArrayResource(image.getBytes()) {
                @Override
                public String getFilename() {
                    return image.getOriginalFilename();
                }
            };

            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
            body.add("image", imageResource);

            HttpEntity<MultiValueMap<String, Object>> requestEntity =
                    new HttpEntity<>(body, headers);

            ResponseEntity<AiScanResponse> response = restTemplate.postForEntity(
                    aiUrl,
                    requestEntity,
                    AiScanResponse.class
            );

            return response.getBody();

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(
                    "Failed to analyze image with AI service: " + e.getMessage(),
                    e
            );
        }
    }
}