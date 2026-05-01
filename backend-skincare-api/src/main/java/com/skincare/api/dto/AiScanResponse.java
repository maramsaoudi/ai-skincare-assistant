package com.skincare.api.dto;

public class AiScanResponse {
    private int overallScore;
    private int acne;
    private int oiliness;
    private int dryness;
    private int redness;
    private String insight;

    public int getOverallScore() {
        return overallScore;
    }

    public void setOverallScore(int overallScore) {
        this.overallScore = overallScore;
    }

    public int getAcne() {
        return acne;
    }

    public void setAcne(int acne) {
        this.acne = acne;
    }

    public int getOiliness() {
        return oiliness;
    }

    public void setOiliness(int oiliness) {
        this.oiliness = oiliness;
    }

    public int getDryness() {
        return dryness;
    }

    public void setDryness(int dryness) {
        this.dryness = dryness;
    }

    public int getRedness() {
        return redness;
    }

    public void setRedness(int redness) {
        this.redness = redness;
    }

    public String getInsight() {
        return insight;
    }

    public void setInsight(String insight) {
        this.insight = insight;
    }
}