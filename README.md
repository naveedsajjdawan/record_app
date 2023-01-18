# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
text:params[:report][:text]

 # @selected_user.reports.create!(text: @report.text)
      # @reportuser = ReportUser.create(report_id:@report.id,user_id:User.find(params[:report][:user_ids][1]))
      # @selected_user = User.find(params[:report][:user_ids][1])

  <div class="field">
    <%= f.label :User %><br/> 
    <%= f.collection_select(:user_ids, User.all, :id,:email,{:prompt => "Please Select a user"},{:multiple => true, size:3 }) %>
  </div>

  text: params[:report][:text]

   # params[:report][:user_ids].each do |id|
        #   next if id.blank?
        #     ReportUser.create(report_id: @report.id, user_id: id)  
        #   # @report.report_users.create(user_id: id)
    # end



        # if @report.update!(text: params[:report][:text],user_ids:params[:report][:user_ids][1])
    #   # ReportUser.create(report_id:@report.id, user_id:params[:report][:user_ids][1])
    #   flash[:notice] = "report update successfully"
    #    redirect_to @report
    # else 
    #   render 'edit'
    # end

    <div class="form-group">
  <%= label_tag :subreports %>
  <%=  select_tag "subreports", options_for_select(@subreports.map{|r| r.text}) %> 
</div>


<ul>
      <% @subreports.each do |r| %>
        
        <li><%= link_to"report", report_path(@report.subreports), class:"btn btn-primary" %></li>
      <%end%>
    </ul>
      # @report.subreports << Report.find_by(id: params[:report][:sub_ids][1]) if params[:report][:sub_ids].compact_blank.present?

      # user.reports.create!(text: params[:report][:text])



       @report = Report.find(params[:id])
    current_user.reports.find_by(id: @report.id).update!(text: params[:report][:text])
      params[:report][:sub_ids].each do |id|
        @report.subreports << Report.find_by(id: id) if id.present?
      end
    params[:report][:user_ids].compact_blank.each do |id|
      user = User.find_by(id: id)
      byebug
      if user.report_ids.include?(@report.id)
        @report.update!(text: params[:report][:text])
      else
        ReportUser.create!(user_id: user.id, report_id: @report.id)
      end
    end
    redirect_to @report
      # ReportUser.create!(user_id: user.id, report_id: @report.id)
        # @report = ReportUser.find_by(report_id: @report.id, user_id: user.id)
        # @report.destroy