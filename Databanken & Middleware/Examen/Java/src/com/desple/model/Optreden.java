package com.desple.model;

import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: Xavier
 * Date: 17/09/13
 * Time: 12:05
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name="optreden")
public class Optreden {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private int id;

    @Column(name="tijdstip")
    private Date tijdstip;

    @Column(name="duur")
    private double duur;

    @Column(name="soundcheck")
    private boolean soundCheck;

    @ManyToOne
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE})
    @JoinColumn(name="festDagId")
    private FestivalDag festivalDag;

    @ManyToOne
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE})
    @JoinColumn(name="playlistId")
    private Playlist playlist;

    @ManyToOne
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE})
    @JoinColumn(name="zoneId")
    private Zone zone;

    @ManyToOne
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE})
    @JoinColumn(name="apparatuurId")
    private BenodigdeApparatuur benodigdeApparatuur;

    public Optreden() {
    }

    public int getId() {
        return id;
    }

    public Date getTijdstip() {
        return tijdstip;
    }

    public void setTijdstip(Date tijdstip) {
        this.tijdstip = tijdstip;
    }

    public double getDuur() {
        return duur;
    }

    public void setDuur(double duur) {
        this.duur = duur;
    }

    public boolean isSoundCheck() {
        return soundCheck;
    }

    public void setSoundCheck(boolean soundCheck) {
        this.soundCheck = soundCheck;
    }

    public FestivalDag getFestivalDag() {
        return festivalDag;
    }

    public void setFestivalDag(FestivalDag festivalDag) {
        this.festivalDag = festivalDag;
    }

    public Playlist getPlaylist() {
        return playlist;
    }

    public void setPlaylist(Playlist playlist) {
        this.playlist = playlist;
    }

    public Zone getZone() {
        return zone;
    }

    public void setZone(Zone zone) {
        this.zone = zone;
    }

    public BenodigdeApparatuur getBenodigdeApparatuur() {
        return benodigdeApparatuur;
    }

    public void setBenodigdeApparatuur(BenodigdeApparatuur benodigdeApparatuur) {
        this.benodigdeApparatuur = benodigdeApparatuur;
    }
}
