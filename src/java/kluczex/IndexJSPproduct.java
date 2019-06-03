package kluczex;
/*klasa uzyta przy stronie index.jsp*/
public class IndexJSPproduct {
    String idProduktu;
    String nazwa;
    String okladka;
    String cena;


    public IndexJSPproduct(String idProduktu, String nazwa, String okladka, String cena) {
        this.idProduktu = idProduktu;
        this.nazwa = nazwa;
        this.okladka = okladka;
        this.cena = cena;
    }

    public String getNazwa() {
        return nazwa;
    }

    public void setNazwa(String nazwa) {
        this.nazwa = nazwa;
    }

    public String getOkladka() {
        return okladka;
    }

    public void setOkladka(String okladka) {
        this.okladka = okladka;
    }

    public String getCena() {
        return cena;
    }

    public void setCena(String cena) {
        this.cena = cena;
    }

    public String getIdProduktu() {
        return idProduktu;
    }

    public void setIdProduktu(String idProduktu) {
        this.idProduktu = idProduktu;
    }

}
