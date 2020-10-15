package hairrang_web.dto;

public class TimeTable {
	private String time;
	private int used;
	
	public TimeTable() {
	}
	
	public TimeTable(String time, int used) {
		this.time = time;
		this.used = used;
	}

	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getUsed() {
		return used;
	}
	public void setUsed(int used) {
		this.used = used;
	}

	@Override
	public String toString() {
		return time + " " + (used == 1 ? "예약됨" : "예약가능함");
	}
	
}
