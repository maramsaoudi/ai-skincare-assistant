package com.skincare.api.dto;

import java.time.LocalDateTime;
import java.util.UUID;

public class ScanHistoryDto {

    private UUID id;
    private Double skinScore;
    private LocalDateTime createdAt;

    public ScanHistoryDto(UUID id, Double skinScore, LocalDateTime createdAt) {
        this.id = id;
        this.skinScore = skinScore;
        this.createdAt = createdAt;
    }

    public UUID getId() {
        return id;
    }

    public Double getSkinScore() {
        return skinScore;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
}