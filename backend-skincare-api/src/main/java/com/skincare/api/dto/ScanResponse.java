package com.skincare.api.dto;

public class ScanResponse {

    private int overallScore;
    private int acne;
    private int oiliness;
    private int dryness;
    private int redness;
    private String insight;

    public ScanResponse(int overallScore, int acne, int oiliness,
                        int dryness, int redness, String insight) {
        this.overallScore = overallScore;
        this.acne = acne;
        this.oiliness = oiliness;
        this.dryness = dryness;
        this.redness = redness;
        this.insight = insight;
    }

    public int getOverallScore() { return overallScore; }
    public int getAcne() { return acne; }
    public int getOiliness() { return oiliness; }
    public int getDryness() { return dryness; }
    public int getRedness() { return redness; }
    public String getInsight() { return insight; }
}