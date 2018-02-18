package com.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.dao.MemberDao;
import com.dao.PlayDao;
import com.dao.TicketDao;
import com.pojo.Member;
import com.pojo.Play;
import com.pojo.Ticket;
import com.util.PageBean;
import com.util.SendHtmlMail;

public class TicketService {
	private TicketDao ticketDao=new TicketDao();

	public void setTicketDao(TicketDao ticketDao) {
		this.ticketDao = ticketDao;
	}
	
	private PlayDao playDao=new PlayDao();
	
	public void setPlayDao(PlayDao playDao) {
		this.playDao = playDao;
	}
	
	private MemberDao memberDao=new MemberDao();

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	/**
	 * ��Ӷ�Ʊ
	 * @param member
	 * @param playId
	 * @param ticketPrice
	 * @param chooseSeatsNum
	 * @return
	 */
	public void createTicket(Member member,Integer playId, Double ticketPrice, int[] chooseSeatsNum){	
		String toEmail="";
		String movieName="";
		Date time=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy��MM��dd�� E HHʱmm��");
		String seat="";
		Double money=0.;
		String ticketCode=member.getMemberEmail().substring(0, member.getMemberEmail().indexOf("@"))+"_"+System.nanoTime();
		for (int ticketSeat : chooseSeatsNum) {
			Play play=playDao.selectById(playId);
			Ticket ticket=new Ticket();
			ticket.setMember(member);
			ticket.setPlay(play);
			ticket.setTicketCode(ticketCode);
			ticket.setTicketDate(new Timestamp(new Date().getTime()));
			ticket.setTicketPrice(ticketPrice);
			ticket.setTicketSeat(ticketSeat);	
			ticket.setTicketFlag(true);
			ticketDao.insert(ticket);
			
			toEmail=ticket.getMember().getMemberEmail();
			movieName=ticket.getPlay().getMovie().getMovieName()+"("+ticket.getPlay().getMovie().getEdition().getEditionName()+")";
			time.setTime(ticket.getPlay().getPlayTime().getTime());
			seat+=ticket.getTicketSeat()+"����λ ";
			money+=ticket.getTicketPrice();
			
			Double memberMoney=member.getMemberMoney()-ticket.getTicketPrice();
			if(memberMoney<0){
//				System.out.println(1/0);
			}else{
				member.setMemberMoney(memberMoney);
				memberDao.update(member);
			}
		}
		
		String HtmlMsg="�𾴵� "+member.getMemberName()+(member.getMemberGender()?"����":"Ůʿ")+" ���ã��뱣�����Ķ�Ʊ��Ϣ��<br/>"+"�����ţ�"+ticketCode+" ��Ӱ��"+movieName+" ����ʱ�䣺"+sdf.format(time)+" "+seat+"��"+money+"Ԫ";
		new SendHtmlMail().sendHtmlMail(toEmail,HtmlMsg);
	}
	
	/**
	 * ��ҳ��ʾ���˶���
	 * @param member
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean findByMemberByPage(Member member,int currentPage, int pageSize){
		return ticketDao.selectByMemberIdByPage(member.getMemberId(), currentPage, pageSize);
	}
	
	/**
	 * ��ʾ���충��
	 * @param member
	 * @return
	 */
	public List<Ticket> findTodayTicket(Member member){
		return ticketDao.selectTodayOrderByMemberId(member.getMemberId());
	}
	
	/**
	 * ��Ʊ
	 * @param ticket
	 * @param member
	 */
	public void modifyReturn(Ticket ticket,Member member){
		Ticket oldTicket=ticketDao.selectById(ticket.getTicketId());
		oldTicket.setTicketFlag(false);
		ticketDao.update(oldTicket);
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy��MM��dd�� E HHʱmm��");
		String toEmail=oldTicket.getMember().getMemberEmail();
		String HtmlMsg="�𾴵� "+member.getMemberName()+(member.getMemberGender()?"����":"Ůʿ")+" ���ã���Ʊ�ɹ�����������Ʊ��Ϣ��<br/>"+"�����ţ�"+oldTicket.getTicketCode()+" ��Ӱ��"+oldTicket.getPlay().getMovie().getMovieName()+" ����ʱ�䣺"+sdf.format(oldTicket.getPlay().getPlayTime())+" "+oldTicket.getTicketSeat()+"��";
		new SendHtmlMail().sendHtmlMail(toEmail,HtmlMsg);
		
		Member oldMember=memberDao.selectById(member.getMemberId());
		oldMember.setMemberMoney(member.getMemberMoney()+oldTicket.getTicketPrice());
		memberDao.update(oldMember);
	}
	
	/**
	 * ����Ʊ
	 * @param ticket
	 */
	public List<Ticket> findTickets(Ticket ticket){
		return ticketDao.selectByCode(ticket.getTicketCode());
	}
	
	/**
	 * ������Ʊ
	 * @param ticket
	 */
	public List<Ticket> findReturnTickets(Ticket ticket){
		return ticketDao.selectReturnByCode(ticket.getTicketCode());
	}
}
