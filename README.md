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